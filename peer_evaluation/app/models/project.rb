class Project < ApplicationRecord
  validates :name, uniqueness: true,presence: true
  validates :project_type, presence: true
end
