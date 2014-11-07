class AddCumulativeTimeToPursuit < ActiveRecord::Migration
  def change
    add_column :pursuits, :cumulative_time, :integer, default: 0
  end
end
