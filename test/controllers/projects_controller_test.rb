require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test 'get index' do
    user = User.create

    get :index, user_id: user.id

    assert_response :success
    assert_template 'index'
    assert assigns :projects
    assert assigns :user
  end

  test 'get show' do
    user = User.create
    project1 = Project.create(user_id: user.id)

    get :show, user_id: user.id, id: project1.id

    assert_response :success
    assert_template 'show'
    assert assigns :project
    assert assigns :user
  end
end
