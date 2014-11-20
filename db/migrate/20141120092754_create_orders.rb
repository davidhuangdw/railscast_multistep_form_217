class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :billing_name
      t.string :shipping_name

      t.timestamps
    end
  end
end
