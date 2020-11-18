class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: true
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    # 半角アルファベット（大文字・小文字・数値）
    validates :password, format: { with: PASSWORD_REGEX, message: 'はアルファベットと数字を含めてください' }, length: { minimum: 6 }
  end
  has_many :desks
  has_many :comments
  has_many :suggestions
end
