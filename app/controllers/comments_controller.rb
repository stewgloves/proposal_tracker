# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
  before_action :set_proposal
  before_action :set_comment, only: [:destroy]
  after_action :verify_authorized, only: [:create, :destroy]

  def create
    @comment = @proposal.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment

    if @comment.save
      redirect_to @proposal, notice: 'Comment was successfully added.'
    else
      redirect_to @proposal, alert: 'Failed to add comment.'
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to @proposal, notice: 'Comment was successfully deleted.'
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end

  def set_comment
    @comment = @proposal.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
