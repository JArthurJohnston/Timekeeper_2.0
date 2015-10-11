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
end