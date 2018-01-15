class AddMoreInfoToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :age, :integer
    add_column :users, :emotional_problem, :string
    add_column :users, :symptom, :string
    add_column :users, :other_info, :text
  end
end
