FactoryBot.define do
  factory :homework do
    title "MyString"
    link "MyLink"
    due_date {Date.tomorrow}
    category "Worksheet"
    teacher_id {User.first.id}
    user_id {User.second.id}
    classroom_id {Classroom.first.id}
  end
end
