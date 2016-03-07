module Api
  class TimesheetController < ApiController

    def create
      render json: Timesheet::NULL
    end

  end
end


