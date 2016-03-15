require_relative 'api_controller_test_case'
require_relative 'rest_api_tests'

module Api

  class StatementsOfWorkControllerTest < ApiControllerTestCase

    include RestApiTests

    private

    def model_symbol
      :statement_of_work
    end

    def model_class
      StatementOfWork
    end

    def check_against_params(sow, params)
      assert_equal params[:number], sow.number
      assert_equal params[:purchase_order_number], sow.purchase_order_number
      assert_equal params[:client], sow.client
      assert_equal params[:nickname], sow.nickname
      assert_equal params[:user_id], sow.user_id
    end

    def valid_params
      return {number: 'SOW1234',
              purchase_order_number: 'fsfl234424',
              client: 'Mickey',
              nickname: 'Mouse',
              user_id: @user.id}
    end

    def invalid_user_params
      other_user = create_user
      return {number: 'SOW1234',
              purchase_order_number: 'fsfl234424',
              client: 'Mickey',
              nickname: 'Mouse',
              user_id: other_user.id}

    end

    def invalid_params
      return {number: 'SOW1234',
              nickname: 'Mouse',
              user_id: @user.id}
    end

    def create_for_invalid_user
      return model_class.create(invalid_user_params)
    end

    def create_for_valid_user
      model_class.create(valid_params)
    end

  end

end
