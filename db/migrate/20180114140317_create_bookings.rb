class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :title
      t.datetime :start_at
      t.datetime :end_at
      t.integer :user_id
      t.integer :psychologist_id
      t.timestamps
    end
  end
end
