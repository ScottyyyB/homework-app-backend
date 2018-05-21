class ChangeStatusColumnForHomework < ActiveRecord::Migration[5.1]
  def change
  	change_column :homework, :status, :string, default: "Pending"
  end
end
