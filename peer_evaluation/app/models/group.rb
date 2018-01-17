class Group < ApplicationRecord
  validates :name, uniqueness: true,presence: true
  validates :group_type, presence: true
end
