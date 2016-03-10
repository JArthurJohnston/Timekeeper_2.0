module Api

  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :js
    before_action :authenticate_user
    after_action :add_cors_headers

    def cor_preflight
      render text: ''
    end

    private

    def add_cors_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    end

    def find_user
      @user = request.method == 'OPTIONS' ? preflight_user : user_from_token
    end

    def authenticate_user
      @user = find_user
      if @user == User::NULL
        head :unauthorized
      end
    end

    def preflight_user
      User::NULL
    end

    def user_from_token
      token = request.env['HTTP_AUTHORIZATION']
      unless token.nil?
        return UserToken.from(token)
      end
      User::NULL
    end
  end

end
