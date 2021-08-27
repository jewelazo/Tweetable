# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Comment.destroy_all
Tweet.destroy_all
User.destroy_all

puts "Start seeding Users"
10.times do
  user_data = { 
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    name: Faker::Artist.name}
  User.create(user_data)
end
puts "Finish seeding Users"

puts "Start seeding Tweets"
user_list = User.all
user_list.each do |user|
  rand(2..3).times do
    tweet_data = { 
      body: Faker::Lorem.paragraph, 
      user: user }
    Tweet.create(tweet_data)
  end
end
puts "Finish seeding Tweets"

puts "Start seeding Comments"
user_list = User.all
tweet_list = Tweet.all

tweet_list.each do |tweet|
    user_list.sample(rand(2..4)).each do |user|
        comment_data = {
        body: Faker::Lorem.paragraph,
        user: user, 
        tweet: tweet }
        Comment.create(comment_data)
    end
end
puts "Finish seeding Comments"
