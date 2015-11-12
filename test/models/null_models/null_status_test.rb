require_relative '../model_test_case'

class NullStatusTest < ModelTestCase

  test 'label is N/A' do
    assert_equal 'N/A', Status::NULL.label
  end

  test 'color is White' do
    assert_equal 'White', Status::NULL.color
  end

  test 'find -1 reutrns NULL staus' do
    assert_equal Status::NULL, Status.find(-1)
    assert_equal Status::NULL, Status.find('-1')

    assert_equal Status::NULL, Status.find_by(id: -1)
    assert_equal Status::NULL, Status.find_by(id: '-1')
  end

  test 'id is -1' do
    assert_equal -1, Status::NULL.id
  end

end