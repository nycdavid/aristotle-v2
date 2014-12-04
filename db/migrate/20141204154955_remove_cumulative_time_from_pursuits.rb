class RemoveCumulativeTimeFromPursuits < ActiveRecord::Migration
  def change
    remove_column :pursuits, :cumulative_time, :integer
  end
end
