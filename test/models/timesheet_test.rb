require_relative 'model_test_case'

class TimesheetTest < ModelTestCase

  def setup
    @timesheet = Timesheet.new
    @timesheet.save
  end

  test 'timesheet has activities' do
    timesheet = Timesheet.new
    timesheet.save
    assert_empty timesheet.activities

    newActivity1 = new_activity_for timesheet
    newActivity2 = new_activity_for timesheet
    newActivity3 = new_activity_for timesheet

    assert_equal 3, timesheet.activities.size
    assert timesheet.activities.include? newActivity1
    assert timesheet.activities.include? newActivity2
    assert timesheet.activities.include? newActivity3
  end

  def new_activity_for aTimesheet
    newActivity = Activity.new
    newActivity.timesheet_id= aTimesheet.id
    newActivity.save
    return newActivity
  end

  test 'timesheet days returns one day when timesheet has no activities' do
    timesheet = Timesheet.create
    assert_equal 1, timesheet.days.size

    start_time = time_on(5, 15)
    act1 = Activity.create(timesheet_id: timesheet.id, start_time: start_time)
  end

  test 'timesheet has current project' do
    project = Project.create
    timesheet = Timesheet.create
    story_card = StoryCard.create(project_id: project.id)
    activity = Activity.create(story_card_id: story_card.id)

    assert_equal Project::NULL, timesheet.current_project
    timesheet.add_activity(activity)

    assert_equal(project, timesheet.current_project)
  end

  test 'timesheet has current story card' do
    story_card = StoryCard.create
    activity = Activity.create(story_card_id: story_card.id)
    timesheet = Timesheet.create

    timesheet.add_activity activity

    assert_equal story_card, timesheet.current_story_card
  end

  test 'timesheet returns a list of day objects' do
    through_date = DateTime.new(2015, 1, 5)
    start_time = DateTime.new(2015, 1, 1)
    timesheet = Timesheet.create

    act1 = Activity.create(timesheet_id: timesheet.id, start_time: start_time)
    act2 = Activity.create(timesheet_id: timesheet.id, start_time: DateTime.new(2015, 1, 3))
    Activity.create(timesheet_id: timesheet.id, start_time: through_date)


    actualDays = timesheet.days
    assert_equal 5, actualDays.size

    expectedDates = [DateTime.new(2015, 1, 1),
                     DateTime.new(2015, 1, 2),
                     DateTime.new(2015, 1, 3),
                     DateTime.new(2015, 1, 4),
                     DateTime.new(2015, 1, 5)]
    actualDays.each do |e|
      assert_not_nil e
    end

    for i in 0..4 do
      timesheetDay = actualDays[i]
      assert_equal timesheet, timesheetDay.timesheet
      assert_equal expectedDates[i], timesheetDay.date
    end

    assert_equal [act1], actualDays[0].activities
    assert_equal [act2], actualDays[2].activities
  end

  test 'add common story card to timesheet' do
    timesheet = Timesheet.create
    timesheet.current_project
  end

  test 'activities are ordered by start time' do
    timesheet = Timesheet.create
    act1 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(5, 15))
    act2 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(4, 30))
    act3 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(6, 0))

    assert_equal 3, timesheet.activities.size
    expectedActivities = [act2, act1, act3]

    actual_activities = timesheet.activities

    (0..(actual_activities.size-1)).each do |i|
      assert_equal expectedActivities[i], actual_activities[i]
    end
  end

  test 'timesheet story cards' do
    story1 = StoryCard.create
    story2 = StoryCard.create
    story3 = StoryCard.create
    story4 = StoryCard.create

    timesheet = Timesheet.create
    Activity.create(timesheet_id: timesheet.id, story_card_id: story1.id)
    Activity.create(timesheet_id: timesheet.id, story_card_id: story2.id)
    Activity.create(timesheet_id: timesheet.id, story_card_id: story1.id)
    Activity.create(story_card_id: story3.id)

    assert_equal [story1, story2], timesheet.story_cards
  end

  test 'destroying a timesheet destroys all its activities' do
    timesheet = Timesheet.create
    timesheet_id = timesheet.id
    act1 = Activity.create(timesheet_id: timesheet_id)
    act1_id = act1.id
    act2 = Activity.create(timesheet_id: timesheet_id)
    act2_id = act1.id
    act3 = Activity.create(timesheet_id: timesheet_id)
    act3_id = act1.id

    timesheet.destroy

    [act1_id, act2_id, act3_id].each do |each_activity_id|
      assert_raises ActiveRecord::RecordNotFound do
        assert_nil Activity.find(each_activity_id)
      end
    end
    
    assert_raises ActiveRecord::RecordNotFound do
      assert_nil Timesheet.find(timesheet_id)
    end
  end

  test 'timesheet belongs to user' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)

    assert_equal user, timesheet.user
  end

  test 'start and end dates are derived from activities' do
    timesheet = Timesheet.create()
    expected_start_date = DateTime.new(2015, 1, 1)
    expected_end_date = DateTime.new(2015, 1, 7)

    Activity.create(timesheet_id: timesheet.id, start_time: expected_start_date)
    Activity.create(timesheet_id: timesheet.id, start_time: expected_end_date)

    assert_equal expected_start_date, timesheet.start_date
    assert_equal expected_end_date, timesheet.through_date
  end

  test 'start and end dates are today when activities are empty' do
    timesheet = Timesheet.create()
    expected_date = DateTime.now

    assert_equal expected_date.to_date, timesheet.start_date.to_date
    assert_equal expected_date.to_date, timesheet.through_date.to_date
  end

  test 'display string' do
    timesheet = Timesheet.create

    Activity.create(timesheet_id: timesheet.id, start_time: time_on(5, 15))
    Activity.create(timesheet_id: timesheet.id, start_time: time_on(8, 30))

    assert_equal 'Thu Jan 1 to Thu Jan 1', timesheet.display_string
  end

  test 'total hours' do
    timesheet = Timesheet.create
    act1 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(5, 15), end_time: time_on(7, 45))
    act2 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(7, 45), end_time: time_on(10, 45))
    assert_equal 5.5, timesheet.total_hours
  end

  test 'returns null activity if current activity is nil' do
    timesheet = Timesheet.create
    assert_equal Activity::NULL, timesheet.current_activity
    assert_equal Project::NULL, timesheet.current_project
    assert_equal StoryCard::NULL, timesheet.current_story_card
  end

  test 'current activity is the last activity' do
    timesheet = Timesheet.create
    assert_equal Activity::NULL, timesheet.current_activity
    assert_empty timesheet.activities

    act1 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(1, 15))
    assert_equal act1, timesheet.current_activity

    act2 = Activity.create(timesheet_id: timesheet.id, start_time: time_on(3, 15))
    assert_equal act2, timesheet.current_activity

    Activity.create(timesheet_id: timesheet.id, start_time: time_on(2, 15))
    assert_equal act2, timesheet.current_activity
  end

  test 'adding an activity only updates current activity when new activity is after current' do
    timesheet = Timesheet.create
    act1_start = time_on(3, 30)
    act1 = Activity.create(start_time: act1_start)
    assert_nil act1.end_time
    timesheet.add_activity(act1)
    assert_equal act1_start, act1.start_time
    assert_nil act1.end_time

    assert_equal act1, timesheet.current_activity

    new_act_start_time = time_on(5, 30)
    act2 = Activity.create(start_time: new_act_start_time)
    timesheet.add_activity(act2)

    assert_equal new_act_start_time, Activity.find(act1.id).end_time

    new_act_start_time = time_on(4, 30)
    act3 = Activity.create(start_time: new_act_start_time)
    timesheet.add_activity(act3)

    assert_nil Activity.find(act2.id).end_time
  end

  test 'adding an acitvity will only update the previous activity if its end is nil' do
    timesheet = Timesheet.create
    act1 = Activity.create(start_time: time_on(9, 45))
    timesheet.add_activity(act1)

    assert_nil act1.end_time

    act2_start = time_on(11, 15)
    act2_end = time_on(13, 45)
    act2 = Activity.create(start_time: act2_start, end_time: act2_end)
    timesheet.add_activity(act2)

    assert_equal act2_start, Activity.find(act1.id).end_time

    act3 = Activity.create(start_time: time_on(15, 30))
    timesheet.add_activity(act3)

    assert_equal act2_end, Activity.find(act2.id).end_time
  end

  test 'deleting a timesheet updates user current timesheet' do
    user = User.create
    sheet1 = user.create_timesheet
    sheet2 = user.create_timesheet

    assert_equal sheet2, user.current_timesheet
    assert_equal 2, user.timesheets.size

    sheet2.destroy

    updated_user = User.find(user.id)
    assert_equal 1, updated_user.timesheets.size
    assert_equal sheet1, updated_user.current_timesheet

    sheet1.destroy
    updated_user = User.find(user.id)

    assert_equal Timesheet::NULL, updated_user.current_timesheet
  end

  test 'user returns NULL when nil' do
    timesheet = Timesheet.create
    assert_equal User::NULL, timesheet.user
  end

  test 'timesheet projects' do
    project1 = Project.create
    project2 = Project.create
    Project.create

    card1 = StoryCard.create project_id: project1.id
    card2 = StoryCard.create project_id: project2.id

    timesheet = Timesheet.create

    act1 = Activity.create timesheet_id: timesheet.id, story_card_id: card1.id
    act1 = Activity.create timesheet_id: timesheet.id, story_card_id: card2.id

    assert_equal [project1, project2], timesheet.projects
  end

  test 'timesheet json' do
    user = create_user
    timesheet = Timesheet.create(user_id: user.id)
    expected_json = '{"id":' +
        timesheet.id.to_s +
        ',"user_id":' +
        user.id.to_s +
        ',"activities":[]}'

    assert_equal expected_json, timesheet.to_json
  end

  test 'timesheet json with activities' do
    user = create_user
    timesheet = Timesheet.create(user_id: user.id)
    act1 = Activity.create(timesheet_id: timesheet.id)
    act2 = Activity.create(timesheet_id: timesheet.id)
    expected_json = '{"id":' +
        timesheet.id.to_s +
        ',"user_id":' +
        user.id.to_s +
        ',"activities":['+ act1.to_json + ',' + act2.to_json + ']}'

    assert_equal expected_json, timesheet.to_json
  end

end
