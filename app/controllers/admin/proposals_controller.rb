# app/controllers/admin/proposals_controller.rb

module Admin
  class ProposalsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      @proposals = Proposal.all.order(created_at: :desc).page(params[:page])
    end

    def show
      @proposal = Proposal.find(params[:id])
    end

    def new
      @proposal = Proposal.new
    end

    def create
      @proposal = Proposal.new(proposal_params)
      if @proposal.save
        redirect_to admin_proposal_path(@proposal), notice: 'Proposal was successfully created.'
      else
        render :new
      end
    end

    def edit
      @proposal = Proposal.find(params[:id])
    end

    def update
      @proposal = Proposal.find(params[:id])
      if @proposal.update(proposal_params)
        redirect_to admin_proposal_path(@proposal), notice: 'Proposal was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @proposal = Proposal.find(params[:id])
      @proposal.destroy
      redirect_to admin_proposals_path, notice: 'Proposal was successfully destroyed.'
    end

    private

    def authorize_admin
      redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
    end

    def proposal_params
      params.require(:proposal).permit(:title, :description, :status, :user_id, :project_id, documents: [])
    end
  end
end
