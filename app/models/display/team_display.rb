module TeamDisplay

  def display_string
    return name
  end

  def as_json(options = {})
    options[:except] ||= [:created_at, :updated_at]
    super
  end
end