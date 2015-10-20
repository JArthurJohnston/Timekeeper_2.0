require_relative '../model_test_case'

class NullStoryCardTest < ModelTestCase

  def setup
    @null_story_card = StoryCard::NULL
  end

  test 'project returns null project' do
    assert_equal Project::NULL, @null_story_card.project
  end

  test 'billable hours is 0' do
    assert_equal 0, @null_story_card.billable_hours
  end

  test 'activities are empty' do
    assert_equal [], @null_story_card.activities
  end

  test 'id is -1' do
    assert_equal -1, @null_story_card.id
  end

end