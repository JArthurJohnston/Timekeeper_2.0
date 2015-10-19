class NullStatementOfWork < StatementOfWork
  include NullModel

  def user
    User::NULL
  end

  def number
    ''
  end

  def purchase_order_number
    ''
  end

  def nickname
    ''
  end

  def client
    ''
  end
end