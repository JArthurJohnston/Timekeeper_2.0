class TimesheetsController < ApplicationController

  def index
    find_user
    @timesheets = @user.timesheets
  end

  def show
    @timesheet = Timesheet.find_by user_id: @user.id, id: params[:id]
  end

  def create
    @user.create_timesheet
    redirect_to action: :index
  end

end
