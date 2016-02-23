class Project < ActiveRecord::Base
  include ProjectDisplay
  extend FindNullModel

  has_many :job_identifiers
  has_many :story_cards, -> {order(:number)}
  belongs_to :user
  belongs_to :team

  NULL = NullProject.new

  def self.find_for_user id, user
    found_project = Project.find(id)
    found_project.for_user(user)
    found_project
  end

  def for_user user
    @user = user
  end
  #
  # def statement_of_work
  #   sow = StatementOfWork.find_by(user_id: @user.id, project_id: self.id)
  #   (sow.nil? || @user.nil?) ? StatementOfWork::NULL : sow
  # end

  def statement_of_work
    sow = StatementOfWork.find(statement_of_work_id)
    sow.nil? ? StatementOfWork::NULL : sow
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
