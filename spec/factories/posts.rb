FactoryBot.define do
  factory :post do
    memo { "御飯" }
    price { 100 }
    user_id { 1 }

    trait :skip_validation do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
