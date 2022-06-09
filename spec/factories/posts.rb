FactoryBot.define do
  factory :post do
    memo { "御飯" }
    price { 100 }
    user_id { 1 }
    category_id { 1 }
  end
end
