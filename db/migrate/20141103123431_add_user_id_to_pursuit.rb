class AddUserIdToPursuit < ActiveRecord::Migration
  def change
    add_column :pursuits, :user_id, :integer
  end
end
