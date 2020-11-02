class CreateBasicTables < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.string :customer_info
      t.string :order_info

      t.timestamps null: false
    end

    create_table :qr_codes do |t|
      t.belongs_to :package
      t.string :code

      t.timestamps null: false
    end

    create_table :packages do |t|
      t.belongs_to :order
      t.string :size
      t.string :info

      t.timestamps null: false
    end
  end
end
