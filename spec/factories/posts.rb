FactoryBot.define do
  factory :post do
    title { "御飯" }
    traffic { 100 }
    food { 100 }
    user_id { 1 }
  end
end
