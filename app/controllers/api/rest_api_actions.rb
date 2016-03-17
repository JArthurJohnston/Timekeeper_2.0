module RestApiActions

  def create
    new_model = model_class.new(model_params)
    if new_model.accessable_by?(@user)
      if new_model.save
        handle_create_for(new_model)
      else
        head :bad_request
      end
    else
      head :forbidden
    end
  end

  def show
    check_model_and_perform {|model| render json: model}
  end

  def update
    check_model_and_perform do
    |model|
      if model.update(model_params)
        render json: model
      else
        head :bad_request
      end
    end
  end

  def destroy
    check_model_and_perform do
    |model|
      model.destroy
      render json: model
    end
  end

  private

  def check_model_and_perform(&block)
    model = model_class.find_by(id: params[:id])
    if model.nil?
      head :not_found
    elsif model.accessable_by?(@user)
      block.call(model)
    else
      head :forbidden
    end
  end

  def handle_create_for(new_model)
    render json: new_model
  end
end
