require_relative 'api_controller_test_case'
module Api
  class ActivitiesApiControllerTest < ApiControllerTestCase

    def setup
      super
      @timesheet = Timesheet.create(user_id: @user.id)
    end

    def create_user_accessable_project
      team = Team.create
      TeamMember.create(team_id: team.id, user_id: @user.id)
      return Project.create(team_id: team.id)
    end

    test 'all for story card' do
      project = create_user_accessable_project
      card = StoryCard.create(project_id: project.id, number: '123')
      act1 = Activity.create(story_card_id: card.id)
      act2 = Activity.create(story_card_id: card.id)
      Activity.create()

      get :all_for_story_card, story_card_id: card.id

      assert_response :success
      assert_equal [act1, act2].to_json, @response.body
    end

    test 'all for a story card the user cant access' do
      project = Project.create
      card = StoryCard.create(project_id: project.id, number: '123')
      Activity.create(story_card_id: card.id)
      Activity.create(story_card_id: card.id)

      get :all_for_story_card, story_card_id: card.id

      assert_response :forbidden
      assert_equal '', @response.body
    end

    test 'get show is successful' do
      activity = Activity.create(timesheet_id: @timesheet.id)

      get :show, id: activity.id
      assert_response :success

      assert_equal activity.to_json, @response.body
    end

    test 'get show is not successful because activity could not be found' do
      get :show, id: 4456
      assert_response :not_found
    end

    test 'get show is unsuccessful because activity is associated with another user' do
      other_user = User.create
      sheet = Timesheet.create(user_id: other_user.id)
      act = Activity.create(timesheet_id: sheet.id)

      # remember, the authentication header has a token for another user
      get :show, id: act.id
      assert_response :forbidden
    end

    test 'post destroy is successful' do
      activity = Activity.create(timesheet_id: @timesheet.id)
      assert @timesheet.activities.include?(activity)

      post :destroy, id: activity.id

      assert_response :success
      refute @timesheet.activities.include?(activity)
      assert_equal activity.to_json, @response.body
    end

    test 'post destroy is unsuccessful with incorrect id' do
      post :destroy, id: 7987

      assert_response :not_found
    end

    test 'post destroy is forbidden with another user' do
      other_user = User.create
      sheet = Timesheet.create(user_id: other_user.id)
      activity = Activity.create(timesheet_id: sheet.id)

      post :destroy, id: activity.id

      assert_response :forbidden
    end

    test 'post update activity is successful' do
      act = Activity.create(timesheet_id: @timesheet.id)
      new_start = DateTime.new(2016, 1, 1, 5, 30, 0)
      new_end = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: new_start, end_time: new_end}

      post :update, {id: act.id, activity: act_params}
      assert_response :success

      updated_activity = Activity.find(act.id)

      check_activity_against_params(updated_activity, act_params)
    end

    test 'post update activity is not successful with incorrect id' do
      new_start = DateTime.new(2016, 1, 1, 5, 30, 0)
      new_end = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: new_start, end_time: new_end}

      post :update, {id: 2349, activity: act_params}
      assert_response :not_found
    end

    test 'post update activity is not successful with incorrect user' do
      other_user = User.create
      sheet = Timesheet.create(user_id: other_user.id)
      act = Activity.create(timesheet_id: sheet.id)
      new_start = DateTime.new(2016, 1, 1, 5, 30, 0)
      new_end = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: new_start, end_time: new_end}

      post :update, {id: act.id, activity: act_params}
      assert_response :forbidden
    end

    test 'post update with invalid parameters' do
      act = Activity.create(timesheet_id: @timesheet.id)
      start = DateTime.new(2016, 1, 1, 10, 30, 0)
      end_before_start = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: start, end_time: end_before_start}

      post :update, {id: act.id, activity: act_params}
      assert_response :bad_request
    end

    test 'post create activity is successful' do
      new_start = DateTime.new(2016, 1, 1, 5, 30, 0)
      new_end = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: new_start, end_time: new_end, timesheet_id: @timesheet.id}

      assert_empty @timesheet.activities

      post :create, activity: act_params

      assert_response :success
      assert_equal 1, @timesheet.activities.size
      new_activity = @timesheet.activities[0]

      check_activity_against_params(new_activity, act_params)
    end

    def check_activity_against_params(activity, params)
      assert_equal @timesheet, activity.timesheet
      assert_equal params[:start_time], activity.start_time
      assert_equal params[:end_time], activity.end_time
      assert_equal activity.to_json, @response.body
    end

    test 'post create activity is not successful with incorrect user' do
      other_user = User.create
      sheet = Timesheet.create(user_id: other_user.id)
      new_start = DateTime.new(2016, 1, 1, 5, 30, 0)
      new_end = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: new_start, end_time: new_end, timesheet_id: sheet.id}

      assert_empty Activity.all

      post :create, activity: act_params

      assert_response :forbidden

      assert_empty Activity.all
    end

    test 'post create with invalid parameters' do
      start_date_time = DateTime.new(2016, 1, 1, 10, 30, 0)
      end_after_start = DateTime.new(2016, 1, 1, 7, 0, 0)
      act_params = {start_time: start_date_time, end_time: end_after_start, timesheet_id: @timesheet.id}

      assert_empty Activity.all

      post :create, activity: act_params

      assert_response :bad_request

      assert_empty Activity.all
    end
  end

end