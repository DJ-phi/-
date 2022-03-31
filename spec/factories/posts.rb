FactoryBot.define do
  factory :post do
    traffic { 1 }
    food { 1 }
    use_day { "2022-03-30 20:06:17" }
    count_price { 1 }
    user_id { 1 }
  end
end
