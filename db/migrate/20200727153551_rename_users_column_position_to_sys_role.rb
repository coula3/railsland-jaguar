class RenameUsersColumnPositionToSysRole < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :position, :sys_role
  end
end
