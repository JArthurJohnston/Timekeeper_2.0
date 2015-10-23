module FindNullModel

  def find *ids
    model_id = ids[0]
    if model_id == -1 || model_id == '-1'
      return self::NULL
    end
    super
  end

  def find_by *args
    model_id = args[0][:id]
    unless model_id.nil?
      if model_id == -1 || model_id == '-1'
        return self::NULL
      end
    end
    super
  end

end