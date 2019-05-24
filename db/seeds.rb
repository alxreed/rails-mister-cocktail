# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_list = open(url).read
list = JSON.parse(ingredient_list)["drinks"]

puts "creating cocktails..."

Ingredient.destroy_all
Cocktail.destroy_all
Review.destroy_all

list.each do |i|
  Ingredient.create!(name: i["strIngredient1"])
end

url2 = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin"
cocktail = open(url2).read
list2 = JSON.parse(cocktail)["drinks"]

list2.each do |c|
  Cocktail.create!(name: c["strDrink"])
end

200.times do
  Review.create!(content: Faker::Lorem.paragraph(4), cocktail: Cocktail.all.sample)
end