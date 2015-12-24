class AddMigrationToSows < ActiveRecord::Migration
  def change
    add_column :statements_of_work, :description, :string
  end
end
