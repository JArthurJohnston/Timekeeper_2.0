module Deletable

  def initialize attributes = nil, options = {}
    unless attributes.nil?
      attributes[:is_deleted] = false
    else
      attributes = {is_deleted: false}
    end
    super
  end

  def destroy
    self.update(is_deleted: true)
  end

end