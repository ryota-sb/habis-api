FactoryBot.define do
  factory :task do
    content { 'Sample Content' }
    is_done { false }
    week { 'monday' }
  end
end