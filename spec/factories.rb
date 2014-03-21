FactoryGirl.define do
  factory :record do
    created_at { Time.now }
    glucose "123"
    weight "100"
  end

  factory :diabetic do
    name CoolFaker::Character.name
    age "100"
    email Faker::Internet.email
  end
end
