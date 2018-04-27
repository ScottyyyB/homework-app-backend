require 'faker'

FactoryBot.define do
  factory :user do
  	email "random@gmail.com"
  	username {Faker::Name.first_name}
  	password "password"
  	password_confirmation "password"
  end
end