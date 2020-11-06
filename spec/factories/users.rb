FactoryBot.define do
  factory :user do
    nickname                { Faker::Name.name }
    email                   { Faker::Internet.free_email }
    password                { 'test1234TEST' }
    password_confirmation   { password }
  end
end
