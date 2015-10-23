require_relative 'model_test_case'
class FindNullModelTest < ModelTestCase

  test 'find and find_by with -1 returns null model' do

    [Timesheet, Activity, StoryCard, StatementOfWork, Project, User].each do
      |each_model_class|
      found_activity = each_model_class.find -1
      found_by_activity = each_model_class.find_by id: -1
      assert_equal each_model_class::NULL, found_activity
      assert_equal each_model_class::NULL, found_by_activity

      found_activity = each_model_class.find '-1'
      found_by_activity = each_model_class.find_by id: '-1'
      assert_equal each_model_class::NULL, found_activity
      assert_equal each_model_class::NULL, found_by_activity

      act = each_model_class.create
      assert_equal act, each_model_class.find(act.id)
      assert_equal act, each_model_class.find_by(id: act.id)
    end

  end

end