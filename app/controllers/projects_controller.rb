class ProjectsController < ApplicationController

  def index
    @projects = @user.projects
  end

  def show
    @project = Project.find_by(user_id: @user.id, id: params[:id])
  end
end
