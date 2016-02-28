require_relative 'model_test_case'

class StoryCardStatusTest < ModelTestCase

  test 'create status' do
    status = Status.create(label: 'In Progress', color: 'Purple')

    found_status = Status.find(status.id)
    assert_equal status, found_status
    assert_equal 'Purple', found_status.color
    assert_equal 'In Progress', found_status.label
  end

end
