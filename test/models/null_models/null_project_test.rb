require_relative '../model_test_case'

class NullProjectTest < ModelTestCase

  def setup
    @null_project = Project::NULL
  end

  test 'id is -1' do
    assert_equal -1, @null_project.id
  end

  test 'returns null user' do
    assert_equal User::NULL, @null_project.user
  end

  test 'statement of work returns null sow' do
    assert_equal StatementOfWork::NULL, @null_project.statement_of_work
  end

  test 'name is empty' do
    assert_equal '', @null_project.name
  end
end