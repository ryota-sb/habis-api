users_num = 20
tasks_num = 3

users_num.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

User.all.each do |user|
  tasks_num.times do
    user.tasks.create(
      content: "sample text",
      is_done: false,
      week: "monday",
      user_id: user
    )
  end
end