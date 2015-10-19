class NullProject < Project
  include NullModel

  def user
    User::NULL
  end

  def statement_of_work
    StatementOfWork::NULL
  end
end