class AddJobIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :job_id, :string
  end
end
