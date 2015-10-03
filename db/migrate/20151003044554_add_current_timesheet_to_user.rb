class AddCurrentTimesheetToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_timesheet_id, :integer
  end
end
