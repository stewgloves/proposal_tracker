# app/controllers/slack_controller.rb

class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def commands
    case params[:command]
    when '/approve_proposal'
      proposal_id = params[:text].strip
      proposal = Proposal.find_by(id: proposal_id)
      if proposal&.approve
        SlackNotifier.notify(channel: params[:channel_id], text: "Proposal *#{proposal.title}* has been approved via Slack.")
        render plain: "Proposal *#{proposal.title}* approved."
      else
        render plain: "Failed to approve proposal. Please check the Proposal ID."
      end
    else
      render plain: "Unknown command."
    end
  end

  def interactions
    payload = JSON.parse(params[:payload])
    if payload['type'] == 'interactive_message' && payload['callback_id'] == 'approve_proposal'
      action = payload['actions'][0]
      action_type = action['name']
      proposal_id = action['value']
      proposal = Proposal.find_by(id: proposal_id)

      if action_type == 'approve' && proposal&.approve
        response_text = "Proposal *#{proposal.title}* has been approved."
        SlackNotifier.notify(channel: payload['channel']['id'], text: response_text)
        render json: { text: response_text }, status: :ok
      elsif action_type == 'reject' && proposal&.reject
        response_text = "Proposal *#{proposal.title}* has been rejected."
        SlackNotifier.notify(channel: payload['channel']['id'], text: response_text)
        render json: { text: response_text }, status: :ok
      else
        render json: { text: "Failed to perform action on proposal." }, status: :ok
      end
    else
      render json: {}, status: :ok
    end
  end
end
