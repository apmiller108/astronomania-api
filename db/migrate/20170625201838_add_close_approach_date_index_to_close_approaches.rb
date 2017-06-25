class AddCloseApproachDateIndexToCloseApproaches < ActiveRecord::Migration[5.1]
  def change
    add_index :asteroid_close_approaches, :close_approach_date
  end
end
