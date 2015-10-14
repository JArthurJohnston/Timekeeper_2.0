require 'test_helper'

class StoryCardActionsTest < ActionDispatch::IntegrationTest

  test 'edit action' do
    user = User.create
    project = Project.create
    story = StoryCard.create(project_id: project.id)

    get edit_user_project_story_card_path(user.id, project.id, story.id)

    assert_response :success
    assert assigns :story_card
    assert assigns :submit_path
    assert_template 'story_cards/_change'

    expected_path = user_project_story_card_path(user.id, project.id, story.id)

    assert_equal story, @controller.instance_variable_get(:@story_card)
    assert_equal expected_path, @controller.instance_variable_get(:@submit_path)
  end


end