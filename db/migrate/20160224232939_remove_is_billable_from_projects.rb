class RemoveIsBillableFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :billable
  end
end
