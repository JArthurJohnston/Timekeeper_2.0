module Api
  class ActivitiesController < ApiController

    @@not_found_act = Activity.new

    def show
      check_activity_and_perform {|act| render json: act.to_json}
    end

    def destroy
      check_activity_and_perform do
        |act|
        act.destroy
        render json: act.to_json
      end
    end


    private

      def find_activity
        act = Activity.find_by(id: params[:id])
        if act.nil?
          return @@not_found_act
        elsif act.user == @user
          return act
        else
          return Activity::NULL
        end
      end

      def check_activity_and_perform &block
        act = find_activity
        if act == Activity::NULL
          head :forbidden
        elsif act == @@not_found_act
          head 404
        else
          block.call(act)
        end
      end
  end
end