FactoryBot.define do
  factory :homework do
    title "MyString"
    link "MyLink"
    due_date {Date.tomorrow}
    category "Worksheet"
  end
end
