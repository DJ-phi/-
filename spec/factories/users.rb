FactoryBot.define do
  factory :user do
    name { "猫" }
    # traffic { 1 }
    # food { 1 }
    # use_day { "2022-03-28 19:21:58" }
    # count_price { 1 }
    password { 1234 }
    email { Faker::Internet.free_email }
    # email { "djedmphi@gmail.com" }
  end
end
