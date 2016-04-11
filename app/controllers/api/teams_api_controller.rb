require_relative 'rest_api_actions'

module Api

  class TeamsApiController < ApiController
    include RestApiActions

    def index
      render json: @user.teams
    end

    private

      def handle_create_for(new_team)
        TeamMember.create(user_id: @user.id, team_id: new_team.id)
        render json: new_team
      end

      def model_params
        params.require(:team).permit(:name, :user_id)
      end

      def model_class
        Team
      end

  end

end
