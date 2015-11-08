class AddBillableToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :billable, :boolean
  end
end
