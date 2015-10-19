class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  has_many :projects, -> {order(:name)}
  belongs_to :user

  NULL = NullStatementOfWork.new

end
