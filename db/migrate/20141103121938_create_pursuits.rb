class CreatePursuits < ActiveRecord::Migration
  def change
    create_table :pursuits do |t|
      t.string :name

      t.timestamps
    end
  end
end
