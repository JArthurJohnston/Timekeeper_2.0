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

  test 'destroy story card action' do
    user = User.create
    projet = Project.create
    story = StoryCard.create(user_id: user.id, project_id: project.id)

    delete user_project_story_card_path(user.id, project.id, story.id)

    assert_nil StoryCard.find_by(id: story.id)

    assert_response :success
    assert_template 'index'
  end

  test 'get select' do
    user = User.create
    project1 = Project.create
    project2 = Project.create
    story1 = StoryCard.create(project_id: project1.id)
    story2 = StoryCard.create(project_id: project1.id)
    story3 = StoryCard.create(project_id: project2.id)

    get user_project_story_card_select_path(user.id, project1.id)

    assert_response :success
    assert_template 'select'
    assert assigns :projects
    assert assigns :story_cards
    assert assigns :selected_project

    assert_equal [story1, story2], @controller.instance_variable_get(:@story_cards)
    assert_equal [project1, project2], @controller.instance_variable_get(:@projects)
    assert_equal project1, @controller.instance_variable_get(:@selected_project)
  end

  test 'index gets story cards for a project' do
    user = User.create
    project1 = Project.create
    project2 = Project.create
    story1 = StoryCard.create(project_id: project1.id)
    story2 = StoryCard.create(project_id: project1.id)
    story3 = StoryCard.create(project_id: project2.id)

    get user_project_story_cards_path(user.id, project1.id)

    assert_response :success
    assert_template 'index'
    assert assigns :story_cards
    assert assigns :projects
    assert assigns :selected_project

    assert_equal [story1, story2], @controller.instance_variable_get(:@story_cards)
    assert_equal [project1, project2], @controller.instance_variable_get(:@projects)
    assert_equal project1, @controller.instance_variable_get(:@selected_project)
  end

  test 'get new story card for activity' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)

    get new_story_card_for_activity_path(user.id, timesheet.id)

    assert_response :success
    assert_template ''
    assert assigns :new_story_card
  end

  test 'delete destroy action' do
    user = User.create
    project = Project.create(user_id: user)
    story = StoryCard.create(project_id: project.id)

    delete user_project_story_card_path(user.id, project.id, story.id)

    assert_response :success
    assert_template 'index'
    assert_nil StoryCard.find_by(id: story.id)
  end

end
