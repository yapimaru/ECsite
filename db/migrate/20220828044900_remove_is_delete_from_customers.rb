class RemoveIsDeleteFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :is_delete, :boolean
  end
end
