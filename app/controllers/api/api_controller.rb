module Api

  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :js
    after_action :add_cors_header

    def create
    end

    def show
    end

    def update
    end

    def destroy
    end

    private

    def add_cors_header
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    def find_user
      @user = User.new
    end
  end

end