class Grouptech < ApplicationRecord
  has_many :recordTech
  has_many :user, through: :recordTech
end
