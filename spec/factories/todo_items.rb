FactoryBot.define do
  factory :todo_item do
    description { Faker::Hobby.activity }
    todo_list
    completed { false }
  end
end
