require 'test_helper'

class JobIdentifierTest < ActiveSupport::TestCase

  test 'create job id' do
    sow = StatementOfWork.create
    project = Project.create
    job_id = JobIdentifier.create(statement_of_work_id: sow.id, project_id: project.id)

    assert_equal sow, job_id.statement_of_work
    assert_equal project, job_id.project
  end

end
