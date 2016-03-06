module Api
  class TimesheetController < ApiController

    def show
      render json: Timesheet::NULL
    end

  end
end


