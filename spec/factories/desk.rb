FactoryBot.define do
  factory :desk do
    title             { Faker::Name.name }
    concept          { 'ワンルームのインテリアです。部屋にはあまり物を置かないようにしています。' }
    association :user

    after(:build) do |desk|
      desk.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end