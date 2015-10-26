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

end
