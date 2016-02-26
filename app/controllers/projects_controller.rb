class ProjectsController < ApplicationController

  def index
    @projects = @user.projects
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
    checked_params = project_params
    project.update(name: checked_params[:name],
                   code: checked_params[:code],
                   team_id: checked_params[:team_id],
                   client: checked_params[:client])
    job_identifier_with(project, checked_params)
    redirect_to action: :index
  end

  def create
    create_params = project_params
    new_project = Project.create(user_id: @user.id,
                   name: create_params[:name],
                   code: create_params[:code],
                   team_id: create_params[:team_id],
                   client: create_params[:client])
    job_identifier_with(new_project, create_params)
    redirect_to user_projects_path(@user.id)
  end

  def project_params
    params.require(:project).permit(:name, :statement_of_work_id, :code, :team_id, :client)
  end

  private
  def job_identifier_with(project, params)
    unless params[:statement_of_work_id].nil?
      job = JobIdentifier.find_by(project_id: project.id)
      if job.nil?
        JobIdentifier.create(project_id: project.id, statement_of_work_id: params[:statement_of_work_id])
      else
        job.update(project_id: project.id, statement_of_work_id: params[:statement_of_work_id])
      end
    end
  end
end
