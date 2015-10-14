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

  test 'get index action' do
    user = User.create
    sow1 = StatementOfWork.create(user_id: user.id)
    sow2 = StatementOfWork.create(user_id: user.id)

    get user_statements_of_work_path(user.id)

    assert_response :success
    assert assigns :statements_of_work
    assert_template 'index'

    assert_equal [sow1, sow2], @controller.instance_variable_get(:@statements_of_work)
  end

  test 'get new action' do
    user = User.create

    get new_user_statement_of_work_path(user.id)

    assert_response :success
    assert assigns :statement_of_work
    assert assigns :submit_path
    assert_template 'statements_of_work/_change'

    assert_equal user_statements_of_work_path(user.id), @controller.instance_variable_get(:@submit_path)
  end

  test 'get edit action' do
    user = User.create
    sow = StatementOfWork.create(user_id: user.id)

    get edit_user_statement_of_work_path(user.id, sow.id)

    assert_response :success
    assert assigns :statement_of_work
    assert assigns :submit_path
    assert_template 'statements_of_work/_change'

    assert_equal user_statement_of_work_path(user.id, sow.id), @controller.instance_variable_get(:@submit_path)
  end

  test 'post update action' do
    user = User.create
    sow = StatementOfWork.create(user_id: user.id)

    sow_params = {number: '12345', client: 'Mikey', nickname: 'Mousey', purchase_order_number: '243242346'}

    patch user_statement_of_work_path(user.id, sow.id, statement_of_work: sow_params)

    assert_response :success
    assert assigns :statement_of_work
    assert_template 'show'

    actual_sow = @controller.instance_variable_get(:@statement_of_work)
    assert_equal sow_params[:number], actual_sow.number
    assert_equal sow_params[:client], actual_sow.client
    assert_equal sow_params[:nickname], actual_sow.nickname
    assert_equal sow_params[:purchase_order_number], actual_sow.purchase_order_number
    assert_equal user.id, actual_sow.user_id
  end

  test 'post create action' do
    user = User.create
    sow = StatementOfWork.create(user_id: user.id)

    sow_params = {number: '1234', client: 'Mickey', nickname: 'Mouse', purchase_order_number: '24324234'}

    post user_statements_of_work_path(user.id, sow.id, statement_of_work: sow_params)

    assert_response :success
    assert assigns :statement_of_work
    assert_template 'show'

    actual_sow = @controller.instance_variable_get(:@statement_of_work)
    assert_equal sow_params[:number], actual_sow.number
    assert_equal sow_params[:client], actual_sow.client
    assert_equal sow_params[:nickname], actual_sow.nickname
    assert_equal sow_params[:purchase_order_number], actual_sow.purchase_order_number
    assert_equal user.id, actual_sow.user_id
  end

end
