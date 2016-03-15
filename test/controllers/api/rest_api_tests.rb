module RestApiTests

  def show_is_successful
    card = create_for_valid_user

    get :show, id: card.id
    assert_response :success

    assert_equal card.to_json, @response.body
  end

  def test_show_is_not_successful_with_invalid_id
    get :show, id: 9999
    assert_response :not_found

    assert_equal '', @response.body
  end

  def test_get_show_is_not_successful_with_incorrect_user
    card = create_for_invalid_user

    get :show, id: card.id
    assert_response :forbidden
    assert_equal '', @response.body
  end

  def test_create_is_successful
    assert_models_are_empty

    post :create, model_symbol => valid_params

    assert_response :success
    assert_equal expected_number_after_create, model_class.all.size
    new_model = newly_created_model
    assert_equal new_model.to_json, @response.body
    check_against_params(new_model, valid_params)
  end

  def newly_created_model
    model_class.all[0]
  end

  def expected_number_after_create
    1
  end

  def test_create_is_not_successful_with_invalid_user
    assert_models_are_empty
    post :create, model_symbol => invalid_user_params
    assert_response :forbidden
    assert_equal '', @response.body
    assert_models_are_empty
  end

  def assert_models_are_empty
    assert_empty model_class.all
  end

  def test_create_is_not_successful_with_invalid_parameters
    assert_models_are_empty

    post :create, model_symbol => invalid_params

    assert_response :bad_request
    assert_equal '', @response.body
    assert_models_are_empty
  end

  def test_post_update_is_successful
    card = create_for_valid_user

    post :update, {id: card.id, model_symbol => valid_params}
    assert_response :success

    check_against_params(card, valid_params)
  end

  def test_post_update_is_not_successful_with_an_invalid_id
    post :update, {id: 345, model_symbol => valid_params}
    assert_response :not_found
    assert_equal '', @response.body
  end

  def test_post_update_is_not_successful_with_invalid_user
    card = create_for_invalid_user

    post :update, {id: card.id, model_symbol => valid_params}
    assert_response :forbidden
    assert_equal '', @response.body
  end

  def test_delete_destroy_is_successful
    model = create_for_valid_user

    delete :destroy, id: model.id
    assert_response :success

    assert_equal model.to_json, @response.body
    assert_nil model_class.find_by(id: model.id)
  end

  def test_delete_destroy_is_not_successful_with_invalid_id
    delete :destroy, id: 999
    assert_response :not_found
    assert_equal '', @response.body
  end

  def test_delete_destroy_is_not_successful_with_invalid_user
    model = create_for_invalid_user

    delete :destroy, id: model.id
    assert_response :forbidden

    assert_equal '', @response.body
    assert_equal model, model_class.find(model.id)
  end

end
