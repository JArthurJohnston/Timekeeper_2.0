class UsersController < ApplicationController

  def find_user
    user_id = params[:id]
    unless user_id.nil?
      @user = authenticate_user
    else
      @user = User::NULL
    end
  end

  def get_user_id
    params[:id]
  end

  def login
    login_params = params[:user_login]
    password = login_params[:password]
    not_validated_user = User.find_by(username: login_params[:username])
    if is_user( not_validated_user.authenticate(password))
      valid_user = not_validated_user
    end

    if valid_user.nil?
      redirect_to show_user_login_path
    else
      session[:user_id] = valid_user.id
      redirect_to user_path(id: valid_user.id)
    end
  end

  def is_user(a_user_or_false)
    if a_user_or_false == false
      return false
    end
    true
  end

  def logout
    session[:user_id] = nil
  end

  def new
    @new_user = User.new
  end

  def create
    if passwords_check?
      user = User.create(user_params)
      redirect_to user_path(user.id)
    else
      redirect_to action: :new
    end
  end

  def passwords_check?
    return password_params[:password].eql?(params[:confirm_password])
  end

  def password_params
    params.require(:user).permit(:password, :confirm_password)
  end

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

end
