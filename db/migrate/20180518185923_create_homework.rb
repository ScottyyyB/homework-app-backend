class CreateHomework < ActiveRecord::Migration[5.1]
  def change
    create_table :homework do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.string :link
      t.date :due_date
      t.string :category
      t.string :status
      t.integer :teacher_id
      t.timestamps
    end
  end
end
