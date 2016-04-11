require_relative 'rest_api_actions'

module Api

  class StoryCardsApiController < ApiController
    include RestApiActions

    def index
      project = Project.find(params[:project_id])
      if project.accessable_by?(@user)
        render json: project.story_cards
      else
        head :forbidden
      end
    end

    private

      def model_params
        params.require(:story_card).permit(:number, :project_id, :title, :description, :estimate, :status)
      end

      def model_class
        StoryCard
      end

  end

end
