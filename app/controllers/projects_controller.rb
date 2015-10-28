class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(user_id: @user.id, id: params[:id])
  end

  def new
    @project = Project.new
    @submit_path = user_projects_path(@user.id)
  end

  def create
    project = Project.create(statement_of_work_id: project_params[:statement_of_work_id],
                             user_id: @user.id, name: project_params[:name])
    redirect_to user_project_path(@user.id, project.id)
  end

  def project_params
    params.require(:project).permit(:name, :statement_of_work_id)
  end
end
