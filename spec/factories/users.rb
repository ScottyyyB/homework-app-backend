require 'faker'

FactoryBot.define do
  factory :user do
  	email "random@gmail.com"
  	name { "#{Faker::Name.last_name} #{Faker::Name.first_name}" }
  	password "password"
  	grade 9
  end
end