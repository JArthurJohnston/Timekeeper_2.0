class CreateStoryCardStatuses < ActiveRecord::Migration
  def change
    create_table :story_card_statuses do |t|
      t.string :label
      t.string :color

      t.timestamps null: false
    end

    Status.create(label: 'In Progress', color: 'Yellow')
    Status.create(label: 'Cancelled', color: 'Blue')
    Status.create(label: 'Done', color: 'Green')
    Status.create(label: 'Stopped', color: 'Blue')
  end
end
