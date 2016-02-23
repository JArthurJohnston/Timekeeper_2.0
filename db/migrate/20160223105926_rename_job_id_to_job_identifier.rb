class RenameJobIdToJobIdentifier < ActiveRecord::Migration
  def change
    rename_table :job_ids, :job_identifiers
  end
end
