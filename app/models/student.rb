class Student < ApplicationRecord
  belongs_to :user
  belongs_to :classroom

  validates :user_id, presence: true
end
