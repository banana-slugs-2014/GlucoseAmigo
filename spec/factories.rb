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

  factory :doctor do
    sequence(:name) { |n| Faker::Name.name + n.to_s }
  	sequence(:fax) { |n| Faker::PhoneNumber.phone_number + n.to_s }
    email Faker::Internet.email
  	comments Faker::Lorem.sentence
	end

end
