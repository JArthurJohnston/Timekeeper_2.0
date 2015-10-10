class ActivitiesController < ApplicationController

  def edit
    @activity = find_activity
    @submit_path = update_path
  end

  def new
    @activity = Activity.new
    @submit_path = create_path
  end

  def find_activity
    return Activity.find_by user_id: params[:user_id], timesheet_id: params[:timesheet_id], id: params[:id]
  end

  def create_path
    user_timesheet_activities_path(params[:user_id], params[:timesheet_id], params[:id])
  end

  def update_path
    user_timesheet_activity_path(params[:user_id], params[:timesheet_id], params[:id])
  end
end
