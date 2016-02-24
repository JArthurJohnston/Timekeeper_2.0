class Project < ActiveRecord::Base
  include ProjectDisplay
  extend FindNullModel

  has_one :job_identifier
  has_many :story_cards, -> {order(:number)}
  belongs_to :user
  belongs_to :team

  NULL = NullProject.new

  def self.find_for_user id, user
    found_project = Project.find(id)
    found_project.for_user(user)
    found_project
  end

  def statement_of_work
    job_id = self.job_identifier
    unless job_id.nil?
      return job_id.statement_of_work
    end
    StatementOfWork::NULL
  end

  def purchase_order_number
    return self.statement_of_work.purchase_order_number
  end

  def invoice_number
    return self.statement_of_work.number
  end

  def client
    return self.statement_of_work.client
  end

end
