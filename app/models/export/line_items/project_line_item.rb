class ProjectLineItem
  attr_reader :timesheet,
              :project

  def initialize timesheet, project
    @timesheet = timesheet
    @project = project
  end

  
end