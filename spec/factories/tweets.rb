FactoryBot.define do
  factory :tweet do
    id { 1 }
    content { "MyText" }
    user_id { 1 }

    trait :for_ensure_correct do
      id { 2 }
      user_id { 2 }
    end

    trait :for_create do
      content { "こんばんわ" }
      user_id { 1 }
    end

    trait :un_update do
      content { "" }
    end

    trait :for_update do
      content { "おはよう" }
      user_id { 1 }
    end
  end
end
