require_relative 'model_test_case'

class ActivityTest < ModelTestCase

  test 'activity MUST have a story card' do
    fail('this caused a 500 internal server error. FIX IT!')
  end

  test 'activity initializes with start and end' do
    expectedStart = DateTime.new(2015, 1, 1, 2, 2, 2)
    expectedEnd = DateTime.new(2015, 1, 1, 3, 3, 3)

    activity = Activity.new(start_time: expectedStart, end_time: expectedEnd)

    assert_equal expectedStart.rounded_to_fifteen_min, activity.start_time
    assert_equal expectedEnd.rounded_to_fifteen_min, activity.end_time
  end

  test 'input and retrieval from database' do
    expectedStart = DateTime.new(2015, 1, 1, 2, 2, 2).rounded_to_fifteen_min
    expectedEnd = DateTime.new(2015, 1, 1, 3, 3, 3).rounded_to_fifteen_min

    activity = Activity.new(start_time: expectedStart, end_time: expectedEnd)
    activity.save

    activityFromDB = Activity.find(activity.id)

    assert_equal activity, activityFromDB
  end

  test 'belongs to a story card and a timesheet' do
    timesheet = Timesheet.new()
    timesheet.save
    storyCard = StoryCard.new()
    storyCard.save

    activity = Activity.new
    activity.story_card_id = storyCard.id
    activity.timesheet_id = timesheet.id

    assert_equal storyCard, activity.story_card
    assert_equal timesheet, activity.timesheet
  end

  test 'activity now' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    now = DateTime.now.rounded_to_fifteen_min
    story = StoryCard.create
    activity = Activity.now timesheet.id, story.id

    deny timesheet.activities.include?activity
    assert_dates_are_close now, activity.start_time
    assert_equal nil, activity.end_time
    assert_equal timesheet, activity.timesheet
    assert_equal story, activity.story_card
    assert_equal user, activity.user
    assert_nil activity.id
  end

  test 'initialize rounds times to nearest 15' do
    expectedStart = DateTime.new(2015, 1, 1, 2, 2, 2)
    expectedEnd = DateTime.new(2015, 1, 1, 3, 8, 3)

    activity = Activity.new(start_time: expectedStart, end_time: expectedEnd)

    assert_equal 0, activity.start_time.minute
    assert_equal 15, activity.end_time.minute
  end

  test 'no args initialize' do
    activity = Activity.new
    assert_nil activity.start_time
    assert_nil activity.end_time
  end

  test 'handles initialize without start or end times' do
    expectedStart = DateTime.new(2015, 1, 1, 2, 2, 2).rounded_to_fifteen_min
    expectedEnd = DateTime.new(2015, 1, 1, 3, 3, 3).rounded_to_fifteen_min

    activity = Activity.new(start_time: expectedStart)
    assert_equal expectedStart, activity.start_time
    assert_nil activity.end_time

    activity = Activity.new(end_time: expectedEnd)
    assert_equal expectedEnd, activity.end_time
    assert_nil activity.start_time
  end

  test 'activity calculates total time' do
    startingTime = time_on(5, 45)
    endingTime = time_on(7, 30)
    activity = Activity.create(start_time: startingTime, end_time: endingTime)
    assert_equal 1.75, activity.total_time

    activity.start_time= startingTime
    activity.save
    assert_equal Float::INFINITY, activity.total_time

    activity.start_time= nil
    activity.end_time= nil
    activity.save
    assert_equal Float::INFINITY, activity.total_time
  end

  test 'activity uses time.now when end_time is nil for total_time' do
    startingTime = time_on(5, 45)

    activity = Activity.create(start_time: startingTime, end_time: nil)

    assert_not_equal Float::INFINITY, activity.total_time
  end

  test 'total_time is zero when start and end are the same' do
    the_time = time_on(5, 45)

    activity = Activity.create(start_time: the_time, end_time: the_time)

    assert_equal 0.0, activity.total_time
  end

  test 'activity has project' do
    assert_nil Activity.create.project

    project = Project.create
    storyCard = StoryCard.create(project_id: project.id)
    activity = Activity.create(story_card_id: storyCard.id)

    assert_equal(project, activity.project)
  end

  test 'activity.timesheet returns null timesheet' do
    act = Activity.create

    assert_equal Timesheet::NULL, act.timesheet

    timesheet = Timesheet.create
    act.update(timesheet_id: timesheet.id)

    assert_equal timesheet, act.timesheet
    assert_equal timesheet, Activity.create(timesheet_id: timesheet.id).timesheet
  end

  test 'activities overlap' do
    act1 = Activity.create(start_time: time_on(5, 15), end_time: time_on(6, 0))
    act2 = Activity.create(start_time: time_on(5, 45), end_time: time_on(7, 0))
    act3 = Activity.create(start_time: time_on(6, 45), end_time: time_on(8, 0))

    assert act1.overlaps? act2
    deny act1.overlaps? act3
  end

  test 'activity date range' do
    start = time_on(5, 15)
    finish = time_on(6, 0)
    act1 = Activity.create(start_time: start, end_time: finish)

    range = act1.range

    assert_equal start, range.start
    assert_equal finish, range.finish
  end

  test 'display string ' do
    project = Project.create(name: 'Mouse')
    story = StoryCard.create(number: '123', project_id: project.id)
    act1 = Activity.create(start_time: time_on(5, 15), end_time: time_on(6, 0), story_card_id: story.id)
    assert_equal 'Mouse 123 - 05:15 to 06:00', act1.display_string
  end

  test 'activity user comes from activity timesheet' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    act = Activity.create(timesheet_id: timesheet.id)

    assert_equal user, act.user
  end

  test 'activity json' do
    sheet = Timesheet.create
    card = create_story_card
    act = Activity.create(start_time: time_on(5, 30), end_time: time_on(7, 45), story_card_id: card.id, timesheet_id: sheet.id)
    expected_json = '{"id":' +
        act.id.to_s + ',"start_time":"2015-01-01T05:30:00.000Z","end_time":"2015-01-01T07:45:00.000Z","timesheet_id":' +
        sheet.id.to_s + ',"story_card_id":' +
        card.id.to_s + ' }'
    assert_equal expected_json, act.to_json
  end

end
