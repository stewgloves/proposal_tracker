# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

admin = User.create!(email: 'admin@example.com', password: 'password', role: 'admin')
user = User.create!(email: 'user@example.com', password: 'password', role: 'user')

project1 = Project.create!(name: 'Project Alpha', description: 'Description for Project Alpha')
project2 = Project.create!(name: 'Project Beta', description: 'Description for Project Beta')

10.times do |i|
  user.proposals.create!(
    title: "Proposal #{i + 1}",
    description: "Description for proposal #{i + 1}",
    status: 'accepted',
    project: project1
  )
end

10.times do |i|
  user.proposals.create!(
    title: "Proposal #{i + 11}",
    description: "Description for proposal #{i + 11}",
    status: 'accepted',
    project: project2
  )
end
