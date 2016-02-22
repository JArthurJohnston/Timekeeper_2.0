class ActivitiesController < ApplicationController

  def edit
    @activity = find_activity
    @submit_path = activity_path
  end

  def new
    @activity = Activity.new
    @submit_path = user_timesheet_activities_path(@user.id, params[:timesheet_id])
  end

  def project_id_from_params
    unless params[:project_select].nil?
      project_id = params[:project_select][:selected_project]
    else
      project_id = params[:project_id]
    end
    project_id
  end

  def new_for_timesheet
    @project = Project.find(project_id_from_params)
    @projects = Project.order(:name)
    @story_cards = @project.story_cards
    @select_symbol = :select_story_card_for_activity
    @project_select_path = new_activity_for_timesheet_path(@user.id, params[:timesheet_id], @project.id)
  end

  def create_for_timesheet
    timesheet = Timesheet.find params[:timesheet_id]
    timesheet.add_activity Activity.now(timesheet.id, params[:story_card_id])
    redirect_to user_timesheet_path(@user.id, timesheet.id)
  end

  def update
    activity = find_activity
    activity.update(activity_params)
    redirect_to user_timesheet_path(@user.id, activity.timesheet_id)
  end

  def create
    timesheet = Timesheet.find(params[:timesheet_id])
    new_activity = Activity.create(activity_params)
    timesheet.add_activity new_activity
    redirect_to user_timesheet_path(@user.id, timesheet.id)
  end

  def destroy
    activity = find_activity
    activity.destroy!
    redirect_to user_timesheet_path(@user.id, params[:timesheet_id])
  end

  def activity_params
    params.require(:activity).permit(:start_time, :end_time, :story_card_id)
  end

  def find_activity
    return Activity.find_by timesheet_id: params[:timesheet_id], id: params[:id]
  end

  def activities_path
    user_timesheet_activities_path(@user.id, params[:timesheet_id], params[:id])
  end

  def activity_path
    user_timesheet_activity_path(@user.id, params[:timesheet_id], params[:id])
  end

end
