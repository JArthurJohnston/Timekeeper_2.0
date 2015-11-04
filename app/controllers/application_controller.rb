class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :html, :js

  before_action :find_user
  around_filter :set_user_timezone

  def set_user_timezone(&block)
    zone_to_use = @user.timezone || 'UTC'
    Time.use_zone(zone_to_use, &block)
  end

  def find_user
    @user = authenticate_user
  end

  def authenticate_user
    session_id = session[:user_id]
    unless session_id.nil?
      if session_id.to_s == params[:user_id].to_s
        return User.find params[:user_id]
      else
        head :forbidden
      end
      # redirect_to user_login_path
      head :forbidden
    end
    nil
  end

  def null_id? id
    return id.to_s == '-1'
  end

end
