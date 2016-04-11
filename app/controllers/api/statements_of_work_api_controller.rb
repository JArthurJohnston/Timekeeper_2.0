require_relative 'rest_api_actions'

module Api

  class StatementsOfWorkApiController < ApiController
    include RestApiActions

    def index
      render json: @user.statements_of_work
    end

    private

    def model_params
      params.require(:statement_of_work).permit(:number, :purchase_order_number, :client, :nickname, :user_id)
    end

    def model_class
      StatementOfWork
    end
  end

end
