class AddNewratingsToTrains < ActiveRecord::Migration[7.1]
  def change
    add_column :trains, :ratings, :integer
  end
end
