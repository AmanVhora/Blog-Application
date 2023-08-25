FactoryBot.define do
  factory(:user) do
    user_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
  end
end
