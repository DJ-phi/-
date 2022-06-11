FactoryBot.define do
  factory :post do
    id { 1 }
    memo { "御飯" }
    price { 100 }
    user_id { 1 }
    category_id { 1 }
    use_day { "2022-06-01" }

    trait :for_create do
      id { 2 }
      memo { "プリン" }
      price {1000 }
      user_id { 1 }
      category_id { 1 }
      # use_day { }
    end

    trait :un_update do
      memo { }
      price { }
      user_id { }
      category_id { }
      # use_day { }
    end

    trait :for_update do
      id { 1 }
      memo { "御飯" }
      price { 1000 }
      user_id { 1 }
      category_id { 1 }
      use_day { "2022-06-01" }
    end
  end
end
