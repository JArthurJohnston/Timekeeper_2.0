require 'test_helper'

class ProjectActionsTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'get index' do
    user = User.create
    project = Project.create(user_id: user.id)

    get user_project_path(user.id, project.id)

    assert_response :success
    assert_template 'show'
    assert assigns :project
    assert assigns :user
  end
end
