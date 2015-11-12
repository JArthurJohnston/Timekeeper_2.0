class CreateStoryCardStatuses < ActiveRecord::Migration
  def change
    create_table :story_card_statuses do |t|
      t.string :label
      t.string :color

      t.timestamps null: false
    end
  end
end
