module Api
  class ActivitiesApiController < ApiController

    @@not_found_act = Activity.new

    def all_for_story_card
      card = StoryCard.find(params[:story_card_id])
      if card.accessable_by?(@user)
        render json: card.activities
      else
        head :forbidden
      end
    end

    def all_for_timesheet
      head :bad_request
    end

    def create
      new_activity = Activity.new(activity_params)
      unless new_activity.user == @user
        head :forbidden
      else
        if new_activity.save
        render json: new_activity
        else
          head :bad_request
        end
      end
    end

    def show
      check_activity_and_perform {|act| render json: act.to_json}
    end

    def update
      check_activity_and_perform do
        |act|
        if act.update(activity_params)
          render json: act
        else
          head :bad_request
        end
      end
    end

    def destroy
      check_activity_and_perform do
        |act|
        act.destroy
        render json: act
      end
    end

    private

      def activity_params
        params.require(:activity).permit(:start_time, :end_time, :timesheet_id, :story_card_id)
      end

      def find_activity
        act = Activity.find_by(id: params[:id])
        return act.nil? ? Activity::NULL : act
      end

      def check_activity_and_perform &block
        act = find_activity
        if act == Activity::NULL
          head :not_found
        elsif act.accessable_by?(@user)
          block.call(act)
        else
          head :forbidden
        end
      end
  end
end