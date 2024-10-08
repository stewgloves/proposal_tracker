# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  # before_action :set_paper_trail_whodunnit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
