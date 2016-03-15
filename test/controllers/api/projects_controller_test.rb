require_relative 'api_controller_test_case'
require_relative 'rest_api_tests'

module Api

  class ProjectsControllerTest < ApiControllerTestCase

    include RestApiTests

    def setup
      super
      @team = Team.create
      TeamMember.create(user_id: @user.id, team_id: @team.id)
      @sow = StatementOfWork.create
    end

    private

    def model_symbol
      :project
    end

    def model_class
      Project
    end

    def check_against_params(project, params)
      assert_equal params[:statement_of_work_id], project.statement_of_work_id
      assert_equal params[:code], project.code
      assert_equal params[:client], project.client
      assert_equal params[:team_id], project.team_id
      assert_equal params[:user_id], project.user_id
    end

    def valid_params
      return {user_id: @user.id,
              code: 'SOW1234',
              name: 'Mouse',
              client: 'Mickey',
              team_id: @team.id,
              statement_of_work_id: @sow.id}
    end

    def invalid_user_params
      other_team = Team.create
      TeamMember.create(team_id: other_team.id, user_id: User.create.id)
      return {user_id: @user.id,
              code: 'SOW1234',
              name: 'Mouse',
              client: 'Mickey',
              team_id: other_team.id,
              statement_of_work_id: @sow.id}

    end

    def invalid_params
      return {user_id: @user.id, statement_of_work_id: @sow.id}
    end

    def create_for_invalid_user
      Project.create(invalid_user_params)
    end


    def create_for_valid_user
      Project.create(valid_params)
    end

  end

end
