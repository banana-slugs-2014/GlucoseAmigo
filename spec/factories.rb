FactoryGirl.define do
  factory :record do
    created_at { Time.now }
    glucose "123"
    weight "100"
  end


  factory :diabetic do
    name CoolFaker::Character.name
    email Faker::Internet.email
  end

  factory :account do
    username 'test'
    email 'testing@testing.com'
    password 'testing'
    password_confirmation 'testing'
  end


end
