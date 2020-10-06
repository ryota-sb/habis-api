FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_user#{n+1}"}
    sequence(:email) { |n| "sample_#{n+1}@example.com"}
    password { 'password' }
  end
end