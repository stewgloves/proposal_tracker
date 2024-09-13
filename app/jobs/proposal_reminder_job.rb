# app/jobs/proposal_reminder_job.rb

class ProposalReminderJob < ApplicationJob
  queue_as :default

  def perform(proposal_id)
    proposal = Proposal.find_by(id: proposal_id)
    return unless proposal&.status == 'under_review'

    # Send reminder notification
    message = "Reminder: Proposal *#{proposal.title}* is pending approval."
    SlackNotifier.notify(channel: '#approvals', text: message)
  end
end
