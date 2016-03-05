class Api::TimesheetApiController < Api::ApiController

  def show
    puts 'I was totally hit'
    @timesheet = Timesheet.new
    render json: {"thingOne": "thingTwo"}
    # response.headers['Access-Control-Allow-Origin'] = '*'
  end

end
