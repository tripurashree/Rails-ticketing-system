class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.integer :confirmation_number

      t.timestamps
    end
    add_index :tickets, :confirmation_number, unique: true
  end
end
