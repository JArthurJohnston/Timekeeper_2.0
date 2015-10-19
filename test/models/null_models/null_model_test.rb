require_relative '../model_test_case'

class NullModelTest < ModelTestCase
  include NullModel

  test 'id is negative one' do
    assert_equal -1, id
  end

end