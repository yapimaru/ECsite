class RenameAddressColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :address, :residence
  end
end
