class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :teacher, :student, inclusion: { in: [true, false] }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
