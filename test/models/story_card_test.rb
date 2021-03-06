require_relative 'model_test_case'

class StoryCardTest < ModelTestCase

  def setup
    @storyCard = StoryCard.create(title: 'Build Lego',
                              number: '001',
                              description: 'make the things',
                              estimate: 4)
  end

  test 'story card fields' do
    status = Status.create(label: 'Done', color: 'Green')
    project = Project.create
    description = 'you need to do all the things'
    cardNumber = 'D123'
    title = 'do something with the thing'
    estimate = 16
    storyCard = StoryCard.new(story_card_status_id: status.id, project_id: project.id, title: title, number: cardNumber, description: description, estimate: estimate)

    assert_equal title, storyCard.title
    assert_equal cardNumber, storyCard.number
    assert_equal description, storyCard.description
    assert_equal estimate, storyCard.estimate
    assert_equal project, storyCard.project
    assert_equal status, storyCard.status
  end

  test 'story card activities' do
    assert_empty @storyCard.activities

    newActivity1 = Activity.create(story_card_id: @storyCard.id)
    newActivity2 = Activity.create(story_card_id: @storyCard.id)
    newActivity3 = Activity.create(story_card_id: @storyCard.id)

    assert_equal 3, @storyCard.activities.size
    assert @storyCard.activities.include? newActivity1
    assert @storyCard.activities.include? newActivity2
    assert @storyCard.activities.include? newActivity3
  end

  test 'story card activities are sorted by start_time' do
    act1 = Activity.create(story_card_id: @storyCard.id, start_time: time_on(5, 45))
    act2 = Activity.create(story_card_id: @storyCard.id, start_time: time_on(4, 15))
    act3 = Activity.create(story_card_id: @storyCard.id, start_time: DateTime.new(2015, 2, 2, 1, 15, 0))

    assert_equal [act2, act1, act3], @storyCard.activities
  end

  test 'billable hours on card' do
    @storyCard.save
    activity1 = Activity.create(start_time: time_on(5, 45), end_time: time_on(7, 30), story_card_id: @storyCard.id)
    activity2 = Activity.create(start_time: time_on(5, 00), end_time: time_on(7, 00), story_card_id: @storyCard.id)
    activity3 = Activity.create(start_time: time_on(7, 00), end_time: time_on(7, 30), story_card_id: @storyCard.id)
    activity4 = Activity.create(start_time: time_on(7, 00), end_time: nil, story_card_id: @storyCard.id)

    assert_equal 4.25, @storyCard.billable_hours
  end

  test 'story card returns null_project when project_id is nil' do
    story = StoryCard.create

    assert_equal Project::NULL, story.project
  end

  test 'returns null status when status_id is -1' do
    story = StoryCard.create

    assert_equal Status::NULL, story.status

    status = Status.create
    story.update(status_id: status.id)

    assert_equal status, story.status
  end

  test 'number and project must be present' do
    project = Project.create()
    card = StoryCard.create(number: '123', project_id: project.id)
    assert_not_nil card.id

    card2 = StoryCard.create()
    assert_nil card2.id
  end

  test 'story card json' do
    project = Project.create()
    card = StoryCard.create(number: '123', title: 'Hi', description: 'World',
                            estimate: 16, project_id: project.id)
    expected_json = '{"id":' +
        card.id.to_s +
        ',"project_id":' +
        project.id.to_s +
        ',"number":"123","title":"Hi","description":"World","estimate":16}'
    assert_equal expected_json, card.to_json
  end
end
