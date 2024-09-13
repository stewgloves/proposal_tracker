# app/controllers/proposals_controller.rb

class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy, :submit_review, :approve, :reject, :schedule, :revert_version]
  after_action :verify_authorized, except: [:index, :show, :export]
  after_action :verify_policy_scoped, only: :index

  def index
    @q = policy_scope(Proposal).ransack(params[:q])
    @proposals = @q.result.includes(:user, :project).order(created_at: :desc).page(params[:page])
  end

  def show
    authorize @proposal
    @comments = @proposal.comments.order(created_at: :desc)
    @comment = Comment.new
    @versions = @proposal.versions
  end

  def new
    @proposal = current_user.proposals.build
    authorize @proposal
  end

  def create
    @proposal = current_user.proposals.build(proposal_params)
    authorize @proposal
    if @proposal.save
      @proposal.send_approval_request if @proposal.under_review?
      redirect_to @proposal, notice: 'Proposal was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @proposal
  end

  def update
    authorize @proposal
    if @proposal.update(proposal_params)
      redirect_to @proposal, notice: 'Proposal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @proposal
    @proposal.destroy
    redirect_to proposals_url, notice: 'Proposal was successfully destroyed.'
  end

  def submit_review
    authorize @proposal
    if @proposal.submit_review!
      @proposal.send_approval_request
      redirect_to @proposal, notice: 'Proposal submitted for review.'
    else
      redirect_to @proposal, alert: 'Unable to submit proposal.'
    end
  end

  def approve
    authorize @proposal
    if @proposal.approve!
      redirect_to @proposal, notice: 'Proposal approved.'
    else
      redirect_to @proposal, alert: 'Unable to approve proposal.'
    end
  end

  def reject
    authorize @proposal
    if @proposal.reject!
      redirect_to @proposal, notice: 'Proposal rejected.'
    else
      redirect_to @proposal, alert: 'Unable to reject proposal.'
    end
  end

  def schedule
    authorize @proposal
    if @proposal.schedule!
      redirect_to @proposal, notice: 'Proposal scheduled.'
    else
      redirect_to @proposal, alert: 'Unable to schedule proposal.'
    end
  end

  def revert_version
    authorize @proposal
    version = @proposal.versions.find(params[:version_id])
    if version.reify && version.reify.save
      redirect_to @proposal, notice: 'Proposal was successfully reverted to the selected version.'
    else
      redirect_to @proposal, alert: 'Failed to revert proposal.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to @proposal, alert: 'Version not found.'
  end

  def export
    authorize Proposal, :export?
    @proposals = policy_scope(Proposal)
    respond_to do |format|
      format.csv { send_data @proposals.to_csv, filename: "proposals-#{Date.today}.csv" }
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def proposal_params
    params.require(:proposal).permit(:title, :description, :project_id, documents: [])
  end
end
