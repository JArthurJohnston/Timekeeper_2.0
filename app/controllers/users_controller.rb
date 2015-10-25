class UsersController < ApplicationController

  def find_user
    user_id = params[:id]
    unless user_id.nil?
      @user = User.find user_id
    end
  end

  def index
    @user = User.find(1)
    @users = User.all
  end
end
