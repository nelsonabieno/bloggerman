FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email 'foo@bar.com'
    password 'password'
  end
end