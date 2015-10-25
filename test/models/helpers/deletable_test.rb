require_relative '../model_test_case'

class DeletableTest < ModelTestCase

  test 'deleting a model only sets is_deleted to true' do
    [Activity, StoryCard, Timesheet, Project, User, StatementOfWork].each do
      |each_model_class|
      each_model_instance = each_model_class.create

      deny each_model_instance.is_deleted

      each_model_instance.destroy

      assert_equal each_model_instance, each_model_class.find(each_model_instance.id)
      assert each_model_instance.is_deleted
    end
  end
end