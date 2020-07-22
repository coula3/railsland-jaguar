class AddVanityNumberToDealers < ActiveRecord::Migration[6.0]
  def change
    add_column :dealers, :vanity_number, :string
  end
end
