class AddExtensionColumnsToDealers < ActiveRecord::Migration[6.0]
  def change
    add_column :dealers, :ext_one, :string
    add_column :dealers, :ext_two, :string
    add_column :dealers, :ext_three, :string
  end
end
