class AddDefaultValueToSysRoleOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :sys_role, 'User')
  end
end
