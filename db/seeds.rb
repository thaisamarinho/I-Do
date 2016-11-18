# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = ['Drinks', 'Church', 'Photos', 'Lights', 'Decoration', 'Invitation', 'Outfits', 'Best Man/Mademoiselle', 'Consulting', 'Music', 'Valet', 'Extra']

for i in 0...tags.count
  Tag.create({name: tags[i]})
end
