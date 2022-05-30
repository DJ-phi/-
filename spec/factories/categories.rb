FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.initials(number: 2) }
    id { 1 }
    user_id { 2 }
  end
end
