class UsersController < ApplicationController
  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  def find_user
    @user = User.find params[:id]
  end
end
