FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.initials(number: 2) }
    id { 1 }
    user_id { 1 }

    trait :for_create do
      id { 2 }
      user_id { 1 }
      name { Faker::Name.unique.initials(number: 2) }
    end

    trait :for_update do
      id { 1 }
      user_id { 1 }
      name { Faker::Name.unique.initials(number: 2) }
    end

    trait :un_update do
      name { "" }
    end
  end
end
