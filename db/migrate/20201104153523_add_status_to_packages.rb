class AddStatusToPackages < ActiveRecord::Migration[6.0]
  def up
    add_column :packages, :status, :integer
  end

  def down
    remove_column :packages, :status
  end
end
