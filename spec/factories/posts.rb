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
  end

  factory :find_post, class: Post do
    memo { "御飯" }
    price { 100 }
    user_id { 1 }
    category_id { 1 }
    use_day { "2022-06-01" }

  #   trait :find_post1 do
  #     memo { "すき家" }
  #     price { 10111111 }
  #     use_day { "2022-06-10" }
  #   end

  #   trait :find_post2 do
  #     memo { "アイス" }
  #     price { 200 }
  #     use_day { "2022-06-20" }
  #   end

  #   trait :find_post3 do
  #     memo { "お茶" }
  #     price { 5000 }
  #     use_day { "2022-06-30" }
  #   end
  end
end
