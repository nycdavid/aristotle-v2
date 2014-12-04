class CreatePomodori < ActiveRecord::Migration
  def change
    create_table :pomodori do |t|
      t.integer :pursuit_id
      t.integer :elapsed_time

      t.timestamps
    end
  end
end
