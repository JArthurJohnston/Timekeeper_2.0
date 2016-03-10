require_relative 'api_controller_test_case'
module Api
  class ActivitiesControllerTest < ApiControllerTestCase

    def setup
      super
      @timesheet = Timesheet.create(user_id: @user.id)
    end

    test 'get show is successful' do
      activity = Activity.create(timesheet_id: @timesheet.id)

      get :show, id: activity.id
      assert_response :success

      assert_equal activity.to_json, @response.body
    end

    test 'get show is not successful because activity could not be found' do
      get :show, id: 4456
      assert_response 404
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

      assert_response 404
    end

    test 'post destroy is forbidden with another user' do
      other_user = User.create
      sheet = Timesheet.create(user_id: other_user.id)
      activity = Activity.create(timesheet_id: sheet.id)

      post :destroy, id: activity.id

      assert_response :forbidden
    end

    test 'post update activity is successful' do
      fail('write me')
    end

    test 'post update activity is not successful with incorrect id' do
      fail('write me')
    end

    test 'post update activity is not successful with incorrect user' do
      fail('write me')
    end

    test 'post create activity is successful' do
      fail('write me')
    end

    test 'post create activity is not successful with incorrect id' do
      fail('write me')
    end

    test 'post create activity is not successful with incorrect user' do
      fail('write me')
    end

  end

end