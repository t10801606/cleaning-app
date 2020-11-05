class Desk < ApplicationRecord
  with_options presence: true do
    validates :title
  end
  belongs_to :user
  has_many :comments
  has_one_attached :image
end
