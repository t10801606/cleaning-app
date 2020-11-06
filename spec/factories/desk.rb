FactoryBot.define do
  factory :item do
    title             { Faker::Name.name }
    concept          { 'ワンルームのインテリアです。部屋にはあまり物を置かないようにしています。' }
    association :user

    after(:build) do |desk|
      desk.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end