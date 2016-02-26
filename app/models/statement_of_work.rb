class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  extend FindNullModel

  has_many :job_identifiers
  belongs_to :user

  NULL = NullStatementOfWork.new

  def projects
    self.job_identifiers.collect {|e| e.project}
  end

end
