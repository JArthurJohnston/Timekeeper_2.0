require_relative '../../../../test/models/model_test_case'
class ProjectLineItemTest < ModelTestCase

  test 'initialize' do
    timesheet = Timesheet.new
    project = Project.new

    line_item = ProjectLineItem.new timesheet, project

    assert_equal timesheet, line_item.timesheet
    assert_equal project, line_item.project

  end
end