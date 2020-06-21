class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone
      t.references :dealer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
