require_relative '../model_test_case'
class ProjectDisplayTest < ModelTestCase

  test 'display string' do
    project = Project.create(name: 'Mouse', code: 'SOW234')

    assert_equal 'Mouse : SOW234' , project.display_string
  end
end