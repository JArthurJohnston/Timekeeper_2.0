module Api

  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :js
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

    def preflight_user
      User::NULL
    end

    def user_from_token
      token = request.env['HTTP_AUTHORIZATION']
      UserToken.from(token)
    end
  end

end
