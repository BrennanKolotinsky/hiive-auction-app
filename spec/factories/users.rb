FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test123-#{n}@hotmail.com"
    end
    password 'test123'
  end
end
