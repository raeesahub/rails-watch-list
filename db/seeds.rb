# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts "Cleaning database..."
Movie.destroy_all
puts "Database cleaned"

url = 'http://tmdb.lewagon.com/movie/top_rated'

movies = JSON.parse(open(url).read)
movies_array = movies['results']

puts "Creating movies..."

movies_array.each do |movie|
  poster_url = "https://image.tmdb.org/t/p/original#{movie['poster_path']}"
  new_movie = Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: poster_url,
    rating: movie['vote_average']
  )

  puts "Creating movie with id: #{new_movie.id}"
end
