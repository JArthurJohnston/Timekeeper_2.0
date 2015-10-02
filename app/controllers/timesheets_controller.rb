class TimesheetsController < ApplicationController

  def index
    @timesheets = Timesheet.all
    # render :partial => 'timesheet/main', :locals => {:user => @user}
  end

end
