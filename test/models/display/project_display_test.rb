require_relative '../model_test_case'
class ProjectDisplayTest < ModelTestCase

  test 'display string' do
    sow = StatementOfWork.create(number:'SOW234', client: 'Mickey')
    project = Project.create(name: 'Mouse', statement_of_work_id: sow.id)

    assert_equal 'Mouse SOW: SOW234' , project.display_string
  end
end