class ChangeJobIdToJobIdentifier < ActiveRecord::Migration
  def change
    rename_column :projects, :job_identifiers, :job_identifier_id
  end
end
