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

  def get_user_id
    params[:user_id]
  end

  def authenticate_user
    session_id = session[:user_id]
    unless session_id.nil?
      if session_id.to_s == get_user_id.to_s
        return User.find get_user_id
      else
        head :forbidden
      end
      # redirect_to user_login_path
      head :forbidden
    end
    redirect_to show_user_login_path
  end

end
