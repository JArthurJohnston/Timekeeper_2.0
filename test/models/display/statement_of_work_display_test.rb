require_relative '../model_test_case'

class StatementOfWorkDisplayTest < ModelTestCase

  test 'display string' do
    sow = StatementOfWork.new
    assert_equal '', sow.display_string
  end
end