# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

Movie.destroy_all

puts "Creating Movies...🎥"

url = "http://tmdb.lewagon.com/movie/top_rated?api_key=<your_api_key>"
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)

movie_arr = movie['results']
english_movies = movie_arr.select { |m| m['original_language'] == 'en' }

english_movies.each do |movie|
    Movie.create(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}",
    rating: movie["vote_average"])
    puts "1 movie created..✅"
end

puts "Seed done, enjoy !"
