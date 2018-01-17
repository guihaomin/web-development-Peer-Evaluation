class Eval < ApplicationRecord
  validates :groupID,  presence: true
  validates :projectID, presence: true
end
