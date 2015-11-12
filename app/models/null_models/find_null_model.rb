module FindNullModel

  def find *ids
    model_id = ids[0]
    if null_id? model_id
      return self::NULL
    end
    super
  end

  def find_by *args
    model_id = args[0][:id]
    unless model_id.nil?
      if null_id? model_id
        return self::NULL
      end
    end
    super
  end

  def null_id? aNumber
    aNumber == -1 || aNumber == '-1'
  end

end