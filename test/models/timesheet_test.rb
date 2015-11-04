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

    newActivity1 = newActivityFor timesheet
    newActivity2 = newActivityFor timesheet
    newActivity3 = newActivityFor timesheet

    assert_equal 3, timesheet.activities.size
    assert timesheet.activities.include? newActivity1
    assert timesheet.activities.include? newActivity2
    assert timesheet.activities.include? newActivity3
  end

  def newActivityFor aTimesheet
    newActivity = Activity.new
    newActivity.timesheet_id= aTimesheet.id
    newActivity.save
    return newActivity
  end

  def dateOn aYear, aMonth, aDay
    return DateTime.new(aYear, aMonth, aDay, 10, 0, 0)
    #added 10 for the hour so that the date wouldnt change with the timezone
  end

  test 'adding an activity sets last activity of timesheet' do
    timesheet = Timesheet.create
    assert_nil timesheet.current_activity_id

    activity = Activity.create

    timesheet.add_activity activity

    assert_equal activity.id, timesheet.current_activity_id
    assert_equal activity, timesheet.current_activity
    assert_equal timesheet.id, activity.timesheet_id
  end

  test 'timesheet days returns one day when timesheet has no activities' do
    timesheet = Timesheet.create
    assert_equal 1, timesheet.days.size

    start_time = time_on(5, 15)
    act1 = Activity.create(timesheet_id: timesheet.id, start_time: start_time)
  end

  test 'adding an activty sets end of previous activity' do
    currentActivity = Activity.create(start_time: time_on(4, 30))
    @timesheet.add_activity currentActivity

    expectedTime = time_on 5, 30
    newActivity = Activity.create(start_time: expectedTime)

    @timesheet.add_activity newActivity

    assert_equal @timesheet.id , newActivity.timesheet_id
    assert_equal newActivity, @timesheet.current_activity

    updatedCurrentActivity = @timesheet.current_activity
    assert_equal expectedTime, updatedCurrentActivity.end_time
    assert_equal @timesheet.id, updatedCurrentActivity.timesheet_id
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

    timesheet = Timesheet.create
    act1 = Activity.create(timesheet_id: timesheet.id, story_card_id: story1.id)
    act2 = Activity.create(timesheet_id: timesheet.id, story_card_id: story2.id)
    act3 = Activity.create(timesheet_id: timesheet.id, story_card_id: story1.id)

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

end
