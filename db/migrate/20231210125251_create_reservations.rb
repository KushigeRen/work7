class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.integer :number_of_guests, null: false
      t.datetime :reservation_datetime, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
