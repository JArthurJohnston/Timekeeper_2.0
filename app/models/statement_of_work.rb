class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  has_many :projects, -> {order(:name)}
  belongs_to :user
  extend FindNullModel

  NULL = NullStatementOfWork.new

end
