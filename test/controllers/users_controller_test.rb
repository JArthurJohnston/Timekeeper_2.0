require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test 'get show' do
    user = User.create
    @controller.session[user_id: user.id]

    get :show, id: user.id

    assert_response :success
    assert assigns :user
    assert_template 'show'
  end

  test 'get new' do
    get :new

    assert_response :success
    assert assigns :user
    assert_template 'change'
  end

  test 'get edit' do
    user = User.create
    @controller.session[user_id: user.id]
    get :edit, id: user.id

    assert_response :success
    assert assigns :user
    assert_template 'change'
  end

  test 'post create' do
    post :create, name: 'harvey', username: 'h_dent', password: 'bigBadHarv', email: 'h_dent@da.gov'

    assert_response :success
    assert assigns :user

    assert_redirected_to :show
  end

  test 'put update' do
    user = User.create
    @controller.session[user_id: user.id]
    put :update, id: user.id, name: 'harvey', username: 'h_dent', password: 'bigBadHarv', email: 'h_dent@da.gov'

    assert_response :success
    assert assigns :user

    assert_redirected_to :show
    updated_user = User.find user.id

    assert_equal 'harvey', updated_user.name
    assert_equal 'h_dent', updated_user.username
    assert_equal 'bigBadHarv', updated_user.password
    assert_equal 'h_dent@da.gov', updated_user.email
  end

  test 'get show_login' do
    get :show_login

    assert_response :success
    assert_template 'show_login'
  end

  test 'post login' do
    user = User.create(username: 'blah', password: 'blahdyblah')

    post :login, username: 'blah', password: 'blahdyblah'

    assert_response :success
    assert assigns :user
  end

  test 'user logout' do
    user = User.create
    @controller.session[:user_id] = user.id

    post :logout, user_id: user.id

    assert_response :success
    assert_template 'logout'

    assert_nil @controller.session[:user_id]
  end

end
