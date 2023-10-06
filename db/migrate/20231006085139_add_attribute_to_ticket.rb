class AddAttributeToTicket < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :booked_by, :integer
  end
end
