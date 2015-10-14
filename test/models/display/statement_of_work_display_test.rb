require_relative '../model_test_case'

class StatementOfWorkDisplayTest < ModelTestCase

  test 'display string' do
    sow = StatementOfWork.new(number: 'SOW00234', client: 'Me')
    assert_equal 'SOW: SOW00234 : Me', sow.display_string
  end
end