class Suggestion < ApplicationRecord
  with_options presence: true do
    validates :place
    # 半角数字のみ
    validates :period_cleaning, numericality: format: { with: /\A[0-9]+\z/ }
    validates :last_cleaned_date
  end
  validates :status, inclusion: { in: [true, false] }
  belongs_to :user
end
