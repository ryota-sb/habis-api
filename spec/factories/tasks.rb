FactoryBot.define do
  factory :task do
    association :user
    content { 'sample content' }
    is_done { false }
    week { 'monday' }
    notification_time { '11:00' }
  end
end