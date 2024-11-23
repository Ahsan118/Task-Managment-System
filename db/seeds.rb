# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
# Create sample users
puts "Creating users..."
users = 5.times.map do |i|
  User.find_or_create_by!(
    email: "user#{i + 1}@example.com"
  ) do |user|
    user.password = "password"
    user.password_confirmation = "password"
  end
end

# Predefined category names
category_names = ["Work", "Personal", "Shopping"]

# Create predefined categories for each user
puts "Creating categories..."
users.each do |user|
  category_names.each do |name|
    Category.find_or_create_by!(
      name: name,
      user: user
    )
  end
end

# Create tasks for each category
puts "Creating tasks..."
Category.all.each do |category|
  5.times do
    Task.find_or_create_by!(
      title: Faker::Lorem.sentence(word_count: 3),
      due_date: Faker::Date.between(from: Date.today, to: 1.month.from_now),
      user: category.user,
      category: category
    ) do |task|
      task.description = Faker::Lorem.paragraph
      task.status = Task.statuses.keys.sample
    end
  end
end

puts "Seeding completed successfully!"
