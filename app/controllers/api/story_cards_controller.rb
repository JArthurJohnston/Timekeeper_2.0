require_relative 'rest_api_actions'

module Api

  class StoryCardsController < ApiController
    include RestApiActions

    private

      def model_params
        params.require(:story_card).permit(:number, :project_id, :title, :description, :estimate, :status)
      end

      def model_class
        StoryCard
      end

  end

end
