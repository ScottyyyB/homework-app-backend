class User < ActiveRecord::Base
  has_many :classrooms, foreign_key: :teacher_id
  has_many :homework

  validates :email, email: true
  validates :username, :email, uniqueness: true
  validates :username, presence: true
  validates :grade, presence: true, if: :student?
  validates :teacher, :student, inclusion: { in: [true, false] }

  has_secure_password
  has_secure_token :auth_token

  def invalidate_token
    self.update_columns(auth_token: nil)
  end

  def self.validate_login(username, password)
    user = find_by(username: username)
    if user && user.authenticate(password)
      user
  	end
  end
  
end
