class ActivitiesController < ApplicationController

  def edit
    @activity = find_activity
  end

  def find_activity
    return Activity.find_by user_id: params[:user_id], timesheet_id: params[:timesheet_id], id: params[:id]
  end
end
