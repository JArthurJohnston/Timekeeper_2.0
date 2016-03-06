class Api::TimesheetApiController < Api::ApiController

  def show
    render json: Timesheet::NULL
  end

end
