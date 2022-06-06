FactoryBot.define do
  factory :user do
      id { 1 }
      name { Faker::Name.initials(number: 2) }
      password { 1234 }
      email { Faker::Internet.unique.free_email }

    trait :for_create do
      id { 4 }
      name { Faker::Name.unique.initials(number: 2) }
      password { 1234 }
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
    trait :skip_validation do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
