require_relative '../model_test_case'
require_relative '../../../test/models/date_test_helper'

class TimesheetCSVTest < ModelTestCase
  include DateTestHelper

  test 'to csv' do
    sow = StatementOfWork.create(client: 'Mickey')
    project = Project.create(name: 'Mouse', job_id: 'SOW456', statement_of_work_id: sow.id)
    card = StoryCard.create(project_id: project.id, number: '123')
    timesheet = Timesheet.create()
    Activity.create(start_time: monday.at(8, 30), end_time: monday.at(11, 45), timesheet_id: timesheet.id)

    assert_equal 'Mickey,SOW456,Mouse DEV - 123,Y,Y,,,2.25,,,,,', timesheet.to_csv
  end

end