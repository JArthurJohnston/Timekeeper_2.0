require 'test_helper'

class StatementOfWorkActionsTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'get show action' do
    user = User.create
    sow = StatementOfWork.create(user_id: user.id)

    get user_statement_of_work_path(user.id, sow.id)

    assert_response :success
    assert assigns :statement_of_work
    assert_template 'show'

    assert_equal sow, @controller.instance_variable_get(:@statement_of_work)
  end
end
