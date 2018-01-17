class User < ApplicationRecord
  has_secure_password
  validates :loginID, uniqueness: true,presence: true
  validates :user_type, presence: true
  validates :name, presence: true
end
