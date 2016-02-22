module TimesheetCSV

  def to_csv
    timesheet_csv = ''
    projects.each do
      |each_project|
      project_csv = ProjectLineItem.line_item_for(self, each_project)
      timesheet_csv.concat(project_csv).concat(empty_line).concat("\n")
    end
    timesheet_csv
  end

  private

    def empty_line
      return ',,,,,,,,,,,'
    end

end