class TimesheetsController < ApplicationController

  def index
    @timesheets = @user.timesheets
  end

  def show
    @timesheet = find_timesheet
  end

  def find_timesheet
    Timesheet.find_by user_id: @user.id, id: params[:id]
  end

  def create
    @user.create_timesheet
    redirect_to action: :index
  end

  def destroy
    timesheet = find_timesheet
    timesheet.destroy!
    redirect_to action: :index
  end

end
