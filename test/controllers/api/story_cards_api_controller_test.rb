require_relative 'api_controller_test_case'
require_relative 'rest_api_tests'

module Api

  class StoryCardsApiControllerTest < ApiControllerTestCase

    include RestApiTests

    def setup
      super
      team = Team.create
      TeamMember.create(team_id: team.id, user_id: @user.id)
      @project = Project.create(team_id: team.id)
    end

    private

    def model_symbol
      :story_card
    end

    def model_class
      StoryCard
    end

    def check_against_params(card, params)
      card_from_db = model_class.find(card.id)
      assert_equal params[:number], card_from_db.number
      assert_equal params[:title], card_from_db.title
      assert_equal params[:estimate], card_from_db.estimate
      assert_equal params[:project_id], card_from_db.project_id
    end

    def valid_params
      return {number: 'T2016',
              title: 'make america greate again',
              description: 'Never gonna happen',
              estimate: 9999,
              project_id: @project.id}
    end

    def invalid_user_params
      return {number: 'T2016',
               title: 'make america greate again',
               description: 'Never gonna happen',
               estimate: 9999,
               project_id: create_invalid_user_project}

    end

    def invalid_params
      return {title: 'make america greate again',
                           description: 'Never gonna happen',
                           estimate: 9999,
                           project_id: @project.id}
    end

    def create_for_invalid_user
      some_project = create_invalid_user_project
      return model_class.create(number: '123',
                              project_id: some_project.id)
    end

    def create_invalid_user_project
      some_user = User.create
      team = Team.create
      TeamMember.create(team_id: team.id, user_id: some_user.id)
      return Project.create(team_id: team.id)
    end

    def create_for_valid_user
      model_class.create(number: '123',project_id: @project.id)
    end

  end

end
