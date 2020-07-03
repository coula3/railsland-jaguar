class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :status, :string, default: :inactive
    add_column :users, :position, :string
  end
end
