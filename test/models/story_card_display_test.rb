require_relative 'model_test_case'

class StoryCardDisplayTest < ModelTestCase

  test 'project number' do
    project = Project.create(name: 'Mouse')
    story = StoryCard.create(number: '123', project_id: project.id)

    assert_equal 'Mouse 123', story.project_number
  end

  test 'display string' do
    project = Project.create(name: 'Mouse')
    story = StoryCard.create(number: '123', project_id: project.id, title: 'Keep it secret', estimate: 16)

    assert_equal 'Mouse 123 : Keep it secret : 16', story.display_string

  end

  test 'actual estimate string' do
    story = StoryCard.create estimate: 16
    Activity.create(story_card_id: story.id, start_time: time_on(1, 15), end_time: time_on(4, 30))

    assert_equal 'Actual/Estimate: 3.25/16', story.actual_estimate_string
  end
end