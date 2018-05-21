class HomeworkSerializer < ActiveModel::Serializer
  attributes :id, :title, :category, :due_date
end
