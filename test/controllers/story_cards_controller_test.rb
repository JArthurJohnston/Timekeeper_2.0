require 'test_helper'

class StoryCardsControllerTest < ActionController::TestCase

  test 'should get index' do
    user = User.create
    project = Project.create(user_id: user.id)
    story = StoryCard.create(project_id: project.id)

    get :index, {user_id: user.id}
    assert_response :success
    assert assigns :story_cards
    assert_template 'index'
  end

  test "should get show" do
    user = User.create
    project = Project.create(user_id: user.id)
    story = StoryCard.create(project_id: project.id)

    get :show, {user_id: user.id, project_id: project.id, id: story.id}
    assert_response :success
    assert assigns :story_card
    assert assigns :user
    assert assigns :activities
    assert_template 'show'
  end

end
