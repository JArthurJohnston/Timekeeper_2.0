class TimesheetsController < ApplicationController

  def index
    find_user
    @timesheets = @user.timesheets
  end

end
