class ActivitiesController < ApplicationController

  def edit
    @activity = find_activity
    @submit_path = activity_path
  end

  def new
    @activity = Activity.new
    @submit_path = activities_path
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
    return Activity.find_by user_id: params[:user_id], timesheet_id: params[:timesheet_id], id: params[:id]
  end

  def activities_path
    user_timesheet_activities_path(params[:user_id], params[:timesheet_id], params[:id])
  end

  def activity_path
    user_timesheet_activity_path(params[:user_id], params[:timesheet_id], params[:id])
  end

end
