class Status < ActiveRecord::Base
  extend FindNullModel

  NULL = NullStatus.new


end
