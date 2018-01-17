class UserAndGroup < ApplicationRecord
  validates :userID,  presence: true
  validates :groupID, presence: true
end
