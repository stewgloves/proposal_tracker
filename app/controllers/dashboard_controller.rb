# app/controllers/dashboard_controller.rb

class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :dashboard, :index?

    # Key Metrics
    @total_proposals = Proposal.count
    @accepted_proposals = Proposal.accepted.count
    @under_review_proposals = Proposal.under_review.count
    @approved_proposals = Proposal.approved.count
    @scheduled_proposals = Proposal.scheduled.count
    @rejected_proposals = Proposal.rejected.count

    # Recent Proposals
    @recent_proposals = Proposal.order(created_at: :desc).limit(5)

    # Proposals by Status Over Time
    @proposals_by_status = Proposal.group_by_day(:created_at).count
  end
end
