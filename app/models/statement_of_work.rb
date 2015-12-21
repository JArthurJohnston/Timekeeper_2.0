class StatementOfWork < ActiveRecord::Base
  include StatementOfWorkDisplay
  extend FindNullModel

  has_many :job_ids
  has_many :projects, -> {order(:name)}
  belongs_to :user

  NULL = NullStatementOfWork.new

  def rate
    sow_rate = super
    unless sow_rate.nil?
      return user.rate
    end
  end
end
