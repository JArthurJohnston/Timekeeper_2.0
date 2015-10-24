class AddIsDeletedFlagToModels < ActiveRecord::Migration
  def change
    add_column :story_cards, :is_deleted, :boolean
    add_column :projects, :is_deleted, :boolean
    add_column :statements_of_work, :is_deleted, :boolean
    add_column :users, :is_deleted, :boolean
    add_column :timesheets, :is_deleted, :boolean
    add_column :activities, :is_deleted, :boolean
  end
end
