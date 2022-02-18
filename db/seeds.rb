# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Clean DB"
Bookmark.delete_all
Movie.delete_all
List.delete_all

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

puts "Creating List...🎥"

file = URI.open('https://www.premiere.fr/sites/default/files/styles/scale_crop_1280x720/public/2018-05/jean-dujardin-oss117-01_0.jpg')
list_french = List.new(name: 'French Movies')
list_french.photo.attach(io: file, filename: 'OSS.png', content_type: 'image/jpg')
list_french.save
puts "French list created !"

file = URI.open('https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/hbz-50-most-romantic-movies-of-all-time-titantic-1517604052.jpg')
list_romantic = List.new(name: 'Romantic Movies')
list_romantic.photo.attach(io: file, filename: 'titanic.png', content_type: 'image/jpg')
list_romantic.save
puts "Romantic list created !"

puts "Seed done, enjoy !"
