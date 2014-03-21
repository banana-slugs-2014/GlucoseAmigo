FactoryGirl.define do
  factory :record do
    created_at { Time.now }
    glucose "123"
    weight "100"
  end

end
