require_relative 'api_integration_test'

class CreateActionsIntegrationTest < ApiIntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def create_story_card
    project = Project.create(client: 'Mickey', code:'1234', name:'Mouse')
    return StoryCard.create(project_id: project.id, number:'001')
  end

  test 'create activity with json' do
    sheet = Timesheet.create(user_id: @user.id)
    card = create_story_card
    act_json = '{"activity":{"start_time":"Thu, 17 Mar 2016 11:00:00 GMT",' +
    '"end_time":"Thu, 17 Mar 2016 12:00:00 GMT",' +
        ' "timesheet_id":'+ sheet.id.to_s + ',' +
        ' "story_card_id": '+ card.id.to_s + '}}'
    assert_empty Activity.all

    post '/api/activities_api/', act_json, all_headers

    assert_response :success
    new_act = Activity.all[0]
    assert_equal(DateTime.new(2016, 3, 17, 11, 0 ,0), new_act.start_time)
    assert_equal(DateTime.new(2016, 3, 17, 12, 0 ,0), new_act.end_time)
    assert_equal(sheet, new_act.timesheet)
    assert_equal(card, new_act.story_card)
  end

  test 'create timesheet' do
    assert_empty @user.timesheets

    post '/api/timesheet_api/', nil, authorization_header

    assert_equal 1, @user.timesheets.size
  end



end
