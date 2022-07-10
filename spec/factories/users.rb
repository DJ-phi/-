FactoryBot.define do
  factory :user do
    id { 1 }
    name { Faker::Name.initials(number: 2) }
    password { 1234 }
    email { Faker::Internet.unique.free_email }

    trait :for_ensure_correct do
      id { 2 }
      name { Faker::Name.initials(number: 2) }
      password { 123_456 }
      email { Faker::Internet.unique.free_email }
    end

    trait :for_create do
      id { 4 }
      name { "test" }
      password { 123_456 }
      email { Faker::Internet.unique.free_email }
    end

    trait :for_update do
      name { Faker::Name.unique.initials(number: 2) }
      password { 1234 }
      email { Faker::Internet.unique.free_email }
    end

    trait :un_update do
      name { Faker::Name.unique.initials(number: 2) }
      password { 1 }
      email { Faker::Internet.unique.free_email }
    end
  end
end
