class AddBase64StringToQrCodes < ActiveRecord::Migration[6.0]
  def up
    add_column :qr_codes, :base64_string, :string
  end

  def down
    remove_column :qr_codes, :base64_string
  end
end
