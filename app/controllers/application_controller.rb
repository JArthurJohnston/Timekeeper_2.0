class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :js

  before_action :find_user

  def find_user
    @user = User.find params[:user_id]
  end

  def null_id? aNumberOrString
    return aNumberOrString == -1 || aNumberOrString == '-1'
  end

end
