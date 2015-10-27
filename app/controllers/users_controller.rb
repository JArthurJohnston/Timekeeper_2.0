class UsersController < ApplicationController

  def find_user
    user_id = params[:id]
    unless user_id.nil?
      @user = User.find user_id
    else
      @user = User::NULL
    end
  end

  def login
    valid_user = User.find_by(username: params[:user_login][:username], password: params[:user_login][:password])
    if valid_user.nil?
      redirect_to :show_login
    else
      session[:user_id] = valid_user.id
      redirect_to user_path(id: valid_user.id)
    end
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
