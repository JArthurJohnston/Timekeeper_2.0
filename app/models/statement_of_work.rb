class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  extend FindNullModel

  has_many :job_ids
  has_many :projects, -> {order(:name)}
  belongs_to :user

  NULL = NullStatementOfWork.new

end
