class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gioitinh, :string
    add_column :users, :ngaysinh, :date
    add_column :users, :diachi, :string
  end
end
