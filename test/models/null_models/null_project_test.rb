require_relative '../model_test_case'

class NullProjectTest < ModelTestCase

  def setup
    @null_project = Project::NULL
  end

  test 'id is -1' do
    assert_equal -1, @null_project.id
  end

  test 'returns null user' do
    assert_equal User::NULL, @null_project.user
  end

  test 'name is N/A' do
    assert_equal 'N/A', @null_project.name
  end

  test 'story cards are empty' do
    assert_empty @null_project.story_cards
  end

end