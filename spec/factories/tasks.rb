FactoryBot.define do
  factory :task do
    association :user
    association :category
    title { "Task #{Faker::Lorem.sentence(word_count: 3)}" }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    due_date { Date.today + rand(1..10).days }
    status { Task.statuses.keys.sample }
  end
end
