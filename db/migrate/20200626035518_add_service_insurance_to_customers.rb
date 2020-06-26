class AddServiceInsuranceToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :service_insurance, :boolean, default: false
  end
end
