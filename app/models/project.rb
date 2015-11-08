class Project < ActiveRecord::Base
  include ProjectDisplay
  extend FindNullModel

  has_many :job_ids
  has_many :story_cards, -> {order(:number)}
  belongs_to :user

  NULL = NullProject.new

  def statement_of_work
    unless statement_of_work_id.nil?
      return StatementOfWork.find(statement_of_work_id)
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
