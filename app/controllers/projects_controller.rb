class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @submit_path = user_projects_path(@user.id)
  end

  def new
    @project = Project.new
    @submit_path = user_projects_path(@user.id)
  end

  def edit
    @project = Project.find(params[:id])
    @submit_path = user_project_path(@user.id, @project.id)
  end

  def update
    project = Project.find(params[:id])
    project.update(project_params)
    redirect_to action:  :index
  end

  def create
    Project.create(statement_of_work_id: project_params[:statement_of_work_id],
                             user_id: @user.id, name: project_params[:name])
    redirect_to user_projects_path(@user.id)
  end

  def project_params
    params.require(:project).permit(:name, :statement_of_work_id, :job_id)
  end
end
