# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
if Rails.env.test?
  user = User.create(email: 'johndoe@person.com', password: 'foo', password_confirmation: 'foo', timezone: 'America/New_York')
  pursuit = Pursuit.create(name: 'Exercise', user_id: user.id, default_pomodoro_length: 1)
end
