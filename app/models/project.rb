class Project < ActiveRecord::Base
  include ProjectDisplay
  extend FindNullModel

  has_many :job_identifiers
  has_many :story_cards, -> {order(:number)}
  belongs_to :user
  belongs_to :team

  NULL = NullProject.new

  def statement_of_work_for user
    sows = StatementOfWork.joins(:job_identifiers).where(statements_of_work: {user_id: user.id})
    sows.empty? ? StatementOfWork::NULL : sows[0]
  end

end
