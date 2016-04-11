module Api
  class TimesheetApiController < ApiController

    def index
      render json: @user.timesheets
    end

    def show
      timesheet = find_timesheet
      unless timesheet.nil?
        render json: timesheet
      else
        head 404
      end
    end

    def create
      timesheet = Timesheet.create(user_id: @user.id)
      render json: timesheet
    end

    def destroy
      timesheet = find_timesheet
      unless timesheet.nil?
        timesheet.destroy
        render json: timesheet
      else
        head 404
      end
    end

    private
      def find_timesheet
        Timesheet.find_by(id: params[:id], user_id: @user.id)
      end
  end
end


