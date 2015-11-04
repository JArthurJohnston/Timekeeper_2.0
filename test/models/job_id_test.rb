require 'test_helper'

class JobIdTest < ActiveSupport::TestCase

  test 'create job id' do
    sow = StatementOfWork.create
    project = Project.create
    expected_number = 'SOW003'
    job_id = JobId.create(statement_of_work_id: sow.id, project_id: project.id, number: expected_number)

    assert_equal expected_number, job_id.number
    assert_equal sow, job_id.statement_of_work
    assert_equal project, job_id.project
  end

end
