class AddDefaultPomodoroLengthToPursuit < ActiveRecord::Migration
  def change
    add_column :pursuits, :default_pomodoro_length, :integer, default: 0
  end
end
