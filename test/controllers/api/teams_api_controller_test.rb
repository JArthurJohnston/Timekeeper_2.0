require_relative 'api_controller_test_case'
require_relative 'rest_api_tests'

module Api

  class TeamsApiControllerTest < ApiControllerTestCase
    include RestApiTests

    def setup
      super
    end

    test 'post successful create makes a team and a team member' do
      assert_equal 1, TeamMember.all.size

      post :create, team: valid_params

      assert_equal 2, TeamMember.all.size
    end

    def newly_created_model
      Team.all[1]
    end

    def expected_number_after_create
      2
    end

    def assert_models_are_empty
      assert_equal 1, Team.all.size
      users_personal_team = Team.all[0]
      assert_equal users_personal_team, @user.teams[0]
      assert_equal 'Personal', users_personal_team.name
    end

    private

    def model_symbol
      :team
    end

    def model_class
      Team
    end

    def check_against_params(team, params)
      assert_equal team.name, params[:name]
      assert_equal team.user_id, params[:user_id]
    end

    def valid_params
      return {name: 'Mickey', user_id: @user.id}
    end

    def invalid_user_params
      other_user = create_user
      return {name: 'Mouse', user_id: other_user.id}

    end

    def invalid_params
      return {user_id: @user.id}
    end

    def create_for_invalid_user
      Team.create(invalid_user_params)
    end


    def create_for_valid_user
      Team.create(valid_params)
    end

  end

end
