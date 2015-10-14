class Project < ActiveRecord::Base
  include ProjectDisplay

  has_many :story_cards, -> {order(:number)}
  belongs_to :statement_of_work
  belongs_to :user

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
