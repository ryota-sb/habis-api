FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "route-#{n}@example.com" }
    password { "password" }
  end
end