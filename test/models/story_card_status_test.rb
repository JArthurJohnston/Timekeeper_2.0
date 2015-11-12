require_relative 'model_test_case'

class StoryCardStatusTest < ModelTestCase

  test 'create status' do
    status = Status.create(label: 'In Progress', color: 'Purple')

    found_status = Status.find(status.id)
    assert_equal status, found_status
    assert_equal 'Purple', found_status.color
    assert_equal 'In Progress', found_status.label
  end

  test 'database has default statuses' do
    assert_equal 4, Status.all.size

    in_progress_status = Status.find(1)
    assert_equal 'In Progress', in_progress_status.label
    assert_equal 'Yellow', in_progress_status.color

    cancelled_status = Status.find(2)
    assert_equal 'Cancelled', cancelled_status.label
    assert_equal 'Blue', cancelled_status.color

    done_status = Status.find(3)
    assert_equal 'Done', done_status.label
    assert_equal 'Green', done_status.color

    stopped_status = Status.find(4)
    assert_equal 'Stopped', stopped_status.label
    assert_equal 'Red', stopped_status.color
  end
end
