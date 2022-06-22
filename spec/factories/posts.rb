FactoryBot.define do
  factory :post do
    id { 1 }
    memo { "御飯" }
    price { 100 }
    user_id { 1 }
    category_id { 1 }
    use_day { "2022-06-01" }
    after(:build) do |post|
      post.image.attach(io: File.open('spec/fixtures/test_image.jpg'), filename: 'test_image.jpg', content_type: 'image/jpg')
    end

    trait :for_create do
      id { 2 }
      memo { "プリン" }
      price { 1000 }
      user_id { 1 }
      category_id { 1 }
    end

    trait :un_update do
      memo {}
      price {}
      user_id {}
      category_id {}
    end

    trait :for_update do
      id { 1 }
      memo { "御飯" }
      price { 1000 }
      user_id { 1 }
      category_id { 1 }
    end

    # 検索機能用のデータ
    trait :test_post1 do
      id { 123 }
      memo { "すき家" }
      price { 10 }
      use_day { "2022-06-10" }
    end

    trait :test_post2 do
      id { 1234 }
      memo { "アイス" }
      price { 200 }
      use_day { "2022-06-20" }
    end

    trait :test_post3 do
      id { 11_234 }
      memo { "お茶" }
      price { 5000 }
      use_day { "2022-06-30" }
    end

    trait :form_post1 do
      memo { "すき家" }
      price { 5000 }
      use_day { "2022-06-28" }
      end_day { "2022-06-30" }
    end

    trait :form_post2 do
      memo { "アイス" }
      price { 5000 }
      use_day { "2022-06-28" }
      end_day { "2022-06-30" }
    end

    trait :form_post3 do
      memo { "お茶" }
      price { 5000 }
      use_day { "2022-06-28" }
      end_day { "2022-06-30" }
    end
  end
end
