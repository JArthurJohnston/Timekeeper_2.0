require 'test_helper'

class StoryCardsControllerTest < ActionController::TestCase

  def setup
    @user = User.create
    @controller.session[:user_id] = @user.id
  end

  test 'should get index' do
    project = Project.create(user_id: @user.id)
    story = StoryCard.create(project_id: project.id)

    get :index, user_id: @user.id, project_id: project.id
    assert_response :success
    assert assigns :story_cards
    assert_template 'index'
  end

  test 'should get show' do
    project = Project.create(user_id: @user.id)
    story = StoryCard.create(project_id: project.id)

    get :show, {user_id: @user.id, project_id: project.id, id: story.id}
    assert_response :success
    assert assigns :story_card
    assert assigns :user
    assert assigns :activities
    assert_template 'show'
  end

  test 'should get new' do
    project = Project.create(user_id: @user.id)

    get :new, {user_id: @user.id, project_id: project.id }

    story_params = {title: 'All our base',
                    description: 'are belong to you',
                    estimate: 32,
                    number: 'G321'}

    assert_response :success
    assert assigns :story_card
    assert assigns :submit_path
    assert_template 'new'

    submit_path_from_controller = @controller.instance_variable_get(:@submit_path)
    assert_not_nil submit_path_from_controller
    assert_equal user_project_story_cards_path(@user.id, project.id), submit_path_from_controller

    new_story_card = @controller.instance_variable_get(:@story_card)
    assert_equal story_params[:title], new_story_card.title
    assert_equal story_params[:description], new_story_card.description
    assert_equal story_params[:estimate], new_story_card.estimate
    assert_equal story_params[:number], new_story_card.number
  end

  test 'should get edit' do
    project = Project.create(user_id: @user.id)
    story = StoryCard.create(project_id: project.id)

    get :edit, user_id: @user.id, project_id: project.id, id: story.id

    assert_response :success
    assert assigns :story_card
    assert assigns :submit_path

    assert_template 'edit'

    submit_path_from_controller = @controller.instance_variable_get(:@submit_path)
    assert_not_nil submit_path_from_controller
    assert_equal user_project_story_card_path(@user.id, project.id), submit_path_from_controller
  end

  test 'should post create' do
    story_params = {title: 'All your base',
                    description: 'are belong to us',
                    estimate: 16,
                    number: 'G123'}

    post :create, {user_id: @user.id, story_card: story_params}

    new_story_card = @controller.instance_variable_get(:@story_card)
    assert_equal story_params[:title], new_story_card.title
    assert_equal story_params[:description], new_story_card.description
    assert_equal story_params[:estimate], new_story_card.estimate
    assert_equal story_params[:number], new_story_card.number
  end

  test 'should post update' do
    project = Project.create(user_id: @user.id)
    story = StoryCard.create(project_id: project.id)

    story_params = {title: 'All your base',
                    description: 'are belong to us',
                    estimate: 16,
                    number: 'G123'}

    post :create, {user_id: @user.id, story_card: story_params}

    new_story_card = @controller.instance_variable_get(:@story_card)

    assert_equal story_params[:title], new_story_card.title
    assert_equal story_params[:description], new_story_card.description
    assert_equal story_params[:estimate], new_story_card.estimate
    assert_equal story_params[:number], new_story_card.number
  end

  test 'get show' do


  end

end
