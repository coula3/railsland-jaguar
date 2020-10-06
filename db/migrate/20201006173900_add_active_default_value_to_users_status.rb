class AddActiveDefaultValueToUsersStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :status, 'active')
  end
end
