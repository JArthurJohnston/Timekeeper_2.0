require_relative '../../../../test/models/model_test_case'

class StatementOfWorkLineItemTest < ModelTestCase

  test 'sow line item csv' do
    sow = StatementOfWork.create client: 'Mickey', purchase_order_number: 'QWERTY123', nickname: 'Mouse', number: '1234', rate: 30.15
    assert_equal ',,Mickey,QWERTY123,0,0,30.15,', sow.to_csv
  end
end