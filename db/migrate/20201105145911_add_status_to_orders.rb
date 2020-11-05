class AddStatusToOrders < ActiveRecord::Migration[6.0]
  def up
    add_column :orders, :status, :integer
    add_reference :orders, :user, index: true
  end

  def down
    remove_column :orders, :status
    remove_index :orders, :user_id
    remove_column :orders, :user_id
  end
end
