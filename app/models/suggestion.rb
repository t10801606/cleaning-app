class Suggestion < ApplicationRecord
  with_options presence: true do
    validates :place
    # 半角数字のみ
    validates :period_cleaning, numericality: { greater_than_or_equal_to: 1, only_integer: true }, format: { with: /\A[0-9]+\z/ }
    validates :last_cleaned_date
  end
  validates :status, inclusion: { in: [true, false] }
  belongs_to :user

  validate :day_after_today
  def day_after_today
    unless last_cleaned_date.nil?
      errors.add(:last_cleaned_date, 'は、今日を含む過去の日付を入力して下さい') if last_cleaned_date > Date.today
    end
  end
end
