class RemoveDefaultValueFromUsersStatus < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :status, nil)
  end
end
