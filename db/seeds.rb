# require_relative 'recovery'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
update_statuses = false
update_passwords = true

if update_statuses
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
end

if update_passwords
  User.all.each do
    |e|
    temp_user = User.new(password: e.password, password_confirmation: e.password)
    e.update(password_digest: e.password_digest)
  end
end


