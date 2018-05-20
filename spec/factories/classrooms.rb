FactoryBot.define do
  factory :classroom do
    grade 10
    name "Math"
    teacher_id { User.third.id }
  end
end
