require_relative 'rest_api_actions'

module Api

  class ProjectsApiController < ApiController
    include RestApiActions

    private

      def model_params
        params.require(:project).permit(:user_id, :name, :team_id, :code, :client, :statement_of_work_id)
      end

      def model_class
        Project
      end

  end

end
