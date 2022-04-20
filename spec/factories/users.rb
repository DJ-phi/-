FactoryBot.define do
  factory :user do
      id { 1 }
      name { Faker::Name.initials(number: 2) }
      # traffic { 1 }
      # food { 1 }
      # use_day { "2022-03-28 19:21:58" }
      # count_price { 1 }
      password { 1234 }
      email { Faker::Internet.free_email }
      # email { "djedmphi@gmail.com" }

    trait :for_create do
      id { 4 }
      name { Faker::Name.initials(number: 2) }
      password { 1234 }
      email { Faker::Internet.free_email }
    end

    trait :for_update do
      name { Faker::Name.initials(number: 2) }
      password { 1234 }
      email { Faker::Internet.free_email }
    end
  end
end
