require_relative 'model_test_case'

class UserTest < ModelTestCase

  test 'user name' do
    expected_name = 'bob loblaw'
    user = User.create(name: expected_name)

    assert_equal expected_name, user.name
  end

  test 'user has timehseets, and statements of work' do
    user = User.create
    assert_empty user.statements_of_work
    assert_empty user.timesheets

    sow = StatementOfWork.create(user_id: user.id)
    timesheet = Timesheet.create(user_id: user.id)

    assert_equal 1, user.statements_of_work.size
    assert_equal 1, user.timesheets.size

    assert user.statements_of_work.include? sow
    assert user.timesheets.include? timesheet
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

  test 'users have team members' do
    user = User.create
    member1 = TeamMember.create(user_id: user.id)
    member2 = TeamMember.create(user_id: user.id)

    team_members = user.team_members
    assert_equal 2, team_members.size
    assert team_members.include? member1
    assert team_members.include? member2
  end

  test 'users have projects through job ids' do
    user1 = User.create
    sow1 = StatementOfWork.create(user_id: user1.id)
    project1 = Project.create
    jobId = JobId.create(project_id: project1.id, statement_of_work_id: sow1.id)

    assert_equal 1, user1.projects.size
    assert user1.projects.include? project1
  end

end
