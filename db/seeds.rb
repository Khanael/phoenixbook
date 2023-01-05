# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clean the database.
p 'Cleaning the database...'
BookBookshelf.destroy_all
Bookshelf.destroy_all
Vote.destroy_all
Book.destroy_all
User.destroy_all
p 'Database cleaned.'

# Create a main sample user.
p 'Creating a main sample user...'
User.create!(email: "toto@toto.com", password: "totototo")
p 'Main sample user created.'
