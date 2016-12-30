class AddGroupIdToPursuits < ActiveRecord::Migration
  def change
    add_column :pursuits, :group_id, :integer
  end
end
