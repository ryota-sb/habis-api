FactoryBot.define do
  factory :task do
    content { "test content" }
    week { "monday" }
    is_done { false }
  end
end 