class Homework < ApplicationRecord
  self.table_name = 'homework'
  belongs_to :teacher, class_name: 'User'
  belongs_to :user 
  belongs_to :classroom
  
  VALID_STATUS= ['Pending', 'Completed', 'Reviewed']
  VALID_CATEGORIES = ['Assignment', 'Worksheet', 'Study']
  validates :title, :link, :due_date, :teacher_id, presence: true
  validates :status, inclusion: { in: VALID_STATUS }
  validates :category, inclusion: { in: VALID_CATEGORIES }
end
