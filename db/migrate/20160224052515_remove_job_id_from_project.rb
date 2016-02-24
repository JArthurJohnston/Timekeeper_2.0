class RemoveJobIdFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :job_identifier_id
    remove_column :job_identifiers, :number
  end
end
