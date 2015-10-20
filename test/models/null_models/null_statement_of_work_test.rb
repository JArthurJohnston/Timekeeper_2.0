require_relative '../model_test_case'
class NullStatementOfWorkTest < ModelTestCase

  def setup
    @null_sow = StatementOfWork::NULL
  end

  test 'fields are empty strings' do
    assert_equal '', @null_sow.number
    assert_equal '', @null_sow.purchase_order_number
    assert_equal '', @null_sow.nickname
    assert_equal '', @null_sow.client
  end

  test 'projects are empty' do
    assert_equal [], @null_sow.projects
  end

  test 'returns null user' do
    assert_equal User::NULL, @null_sow.user
  end

  test 'id is -1' do
    assert_equal -1, StatementOfWork::NULL.id
  end

end