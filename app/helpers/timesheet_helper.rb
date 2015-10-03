module TimesheetHelper

  def timesheet_home_button_for aTimesheet
    if aTimesheet.nil?
      new_timesheet_button
    else
      link_to aTimesheet do
        concat content_tag :div, aTimesheet.display_string
      end
    end
  end

  def new_timesheet_button
    link_to new_user_timesheet_path(@user.id) do
      concat content_tag :div, 'Create Timesheet'
    end
  end

end