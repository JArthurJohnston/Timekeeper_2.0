class AddStatusToStoryCards < ActiveRecord::Migration
  def change
    add_column :story_cards, :status_id, :integer
  end
end
