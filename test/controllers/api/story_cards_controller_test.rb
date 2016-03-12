require_relative 'api_controller_test_case'

module Api

  class StoryCardsControllerTest < ApiControllerTestCase

    test 'get show is successful' do
      card = StoryCard.create

      get :show, id: card.id
      assert_response :success

      assert_equal card.to_json, @response.body
    end

    test 'get show is not successful with invalid id' do
      get :show, id: 9999
      assert_response :not_found

      assert_equal '', @response.body
    end

    test 'get show is not successful with incorrect user' do
      fail('Ill need to add is_viewable_by(user) to story card and other models')
    end


  end

end
