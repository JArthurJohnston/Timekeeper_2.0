class CreateStoryCardStatuses < ActiveRecord::Migration
  def change
    create_table :story_card_statuses do |t|
      t.string :label
      t.string :color

      t.timestamps null: false
    end

    StoryCardStatus.create(label: 'In Progress', color: 'Yellow')
    StoryCardStatus.create(label: 'Cancelled', color: 'Blue')
    StoryCardStatus.create(label: 'Done', color: 'Green')
    StoryCardStatus.create(label: 'Stopped', color: 'Blue')
  end
end
