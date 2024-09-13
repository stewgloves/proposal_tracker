# app/controllers/admin/projects_controller.rb

module Admin
  class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      @projects = Project.all.order(created_at: :desc).page(params[:page])
    end

    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to admin_project_path(@project), notice: 'Project was successfully created.'
      else
        render :new
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def update
      @project = Project.find(params[:id])
      if @project.update(project_params)
        redirect_to admin_project_path(@project), notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to admin_projects_path, notice: 'Project was successfully destroyed.'
    end

    private

    def authorize_admin
      redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
  end
end
