require_relative 'model_test_case'

class RecoveryTest < ModelTestCase

  test 'recovery works' do
    assert Activity.all.empty?
    # rec = Recovery.new
    # rec.recover

    assert_equal 15, Activity.all.size

  end

end