class AddStartTimeToPomodoro < ActiveRecord::Migration
  def change
    add_column :pomodori, :start_time, :datetime
    add_column :pomodori, :end_time, :datetime
  end
end
