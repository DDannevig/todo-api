FactoryBot.define do
  factory :todo_list do
    name { Faker::Hobby.activity }
  end

  trait :with_items do
    after :create do |list|
      # create(:todo_item, todo_list: list)
      create_list(:todo_item, 100, todo_list: list)
    end
  end
end
