# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Array.new(5) do
  Cat.create!(name: Faker::Name.name,
          birth_date: Faker::Date.birthday(0,7),
          color: Faker::Commerce.color.to_s,
          sex: ['M', 'F'].sample,
          description: Faker::Hacker.say_something_smart
  )
end
