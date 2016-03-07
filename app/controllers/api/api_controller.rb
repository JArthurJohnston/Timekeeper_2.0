module Api

  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :js
    after_action :add_cors_header

    private

    def add_cors_header
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    def find_user
      token = request.env['Authorization']
      puts token.to_s
      @user = UserToken.from(token)
    end
  end

end