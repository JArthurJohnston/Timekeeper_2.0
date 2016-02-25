# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

statuses = [
    ['In Progress', 'Yellow'],
    ['Canceled', 'Blue'],
    ['Done', 'Orange'],
    ['Completed', 'Green'],
    ['Stopped', 'Red'],
    ['None', 'White'],
]

statuses.each do
  |label, color|
  Status.create(label: label, color: color)
end

Project.all.each do
  |e|
  StoryCard.create(number: 'STU', title: 'Stand Up', project_id: e.id)
  StoryCard.create(number: 'KIK', title: 'Kick Off', project_id: e.id)
  StoryCard.create(number: 'EST', title: 'Estimation', project_id: e.id)
  StoryCard.create(number: 'SHP', title: 'Show And Tell Prep', project_id: e.id)
  StoryCard.create(number: 'SHO', title: 'Show And Tell', project_id: e.id)
  StoryCard.create(number: 'PLG', title: 'Planning Game', project_id: e.id)
  StoryCard.create(number: 'MCR', title: 'Manage Client Communications', project_id: e.id)
end