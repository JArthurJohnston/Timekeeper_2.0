require_relative 'model_test_case'

class UserTest < ModelTestCase

  test 'user name' do
    expected_name = 'bob loblaw'
    user = User.create(name: expected_name)

    assert_equal expected_name, user.name
  end

  test 'user has timehseets, statements of work and activities' do
    user = User.create
    assert_empty user.statements_of_work
    assert_empty user.timesheets
    assert_empty user.activities

    sow = StatementOfWork.create(user_id: user.id)
    timesheet = Timesheet.create(user_id: user.id)
    activity = Activity.create(user_id: user.id)

    assert_equal 1, user.statements_of_work.size
    assert_equal 1, user.timesheets.size
    assert_equal 1, user.activities.size

    assert user.statements_of_work.include? sow
    assert user.timesheets.include? timesheet
    assert user.activities.include? activity
  end

  test 'add timesheet to user' do
    user = User.create

    timesheet = user.create_timesheet

    assert_equal user, timesheet.user

    actual_timesheet = Timesheet.find(timesheet.id)

    assert_equal timesheet, actual_timesheet
    assert_equal timesheet, user.current_timesheet
  end

  test 'user has current project' do
    expected_project = Project.create
    story_card = StoryCard.create(project_id: expected_project.id)
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    user.update(current_timesheet_id: timesheet.id)
    activity = Activity.create(timesheet_id: timesheet.id, story_card_id: story_card.id)
    timesheet.add_activity activity

    assert_equal expected_project, user.current_project
  end

  test 'current project is nil if activity is nil' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    user.update(current_timesheet_id: timesheet.id)

    assert_equal Project::NULL, user.current_project
  end

  test 'current story card is NULL sotry card if activity is nil' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    user.update(current_timesheet_id: timesheet.id)

    assert_equal StoryCard::NULL, user.current_story_card
  end

  test 'current timesheet returns null timesheet when nil' do
    user = User.create
    assert_equal Timesheet::NULL, user.current_timesheet

    timesheet = user.create_timesheet

    assert_equal timesheet, user.current_timesheet
  end

  test 'current activity is NULL activity when nil' do
    user = User.create

    assert_equal Activity::NULL, user.current_activity
  end

  test 'users have teams' do
    fail()
  end

end
