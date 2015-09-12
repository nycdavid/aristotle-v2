class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :code
      t.integer :user_id
      t.boolean :used, default: false
      t.timestamps null: false
    end
  end
end
