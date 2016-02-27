class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  extend FindNullModel

  has_many :job_identifiers
  belongs_to :user

  after_destroy :destroy_my_job_identifiers

  NULL = NullStatementOfWork.new

  def projects
    self.job_identifiers.collect {|e| e.project}
  end

  private
    def destroy_my_job_identifiers
      job_identifiers.each {|e| e.destroy }
    end
end
