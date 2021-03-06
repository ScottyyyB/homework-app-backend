class User < ActiveRecord::Base
  has_many :classrooms, foreign_key: :teacher_id
  has_many :homework

  validates :email, email: true
  validates :name, :email, uniqueness: true
  validates :name, presence: true
  validates :grade, presence: true, if: :student?
  validates :teacher, inclusion: { in: [false] }, if: :student?
  validates :student, inclusion: { in: [false] }, if: :teacher?


  has_secure_password
  has_secure_token :auth_token

  def invalidate_token
    self.update_columns(auth_token: nil)
  end

  def self.validate_login(name, password)
    user = find_by(name: name)
    if user && user.authenticate(password)
      user
  	end
  end
  
end
