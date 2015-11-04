class CreateJobIds < ActiveRecord::Migration
  def change
    create_table :job_ids do |t|
      t.string :number
      t.integer :project_id
      t.integer :statement_of_work_id

      t.timestamps null: false
    end
  end
end
