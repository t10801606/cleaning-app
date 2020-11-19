FactoryBot.define do
  factory :suggestion do
    place               { 'デスク' }
    status              { true }
    period_cleaning     { 7 }
    last_cleaned_date   { Date.today-3 }
    association :user
  end
end
