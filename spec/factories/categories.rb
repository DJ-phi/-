FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.initials(number: 2) }
    id { 1 }
    trait :skip_validation do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
