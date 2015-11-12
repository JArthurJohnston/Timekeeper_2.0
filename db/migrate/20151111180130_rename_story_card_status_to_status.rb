class RenameStoryCardStatusToStatus < ActiveRecord::Migration
  def change
    rename_table :story_card_statuses, :statuses
  end
end
