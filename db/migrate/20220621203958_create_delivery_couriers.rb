class CreateDeliveryCouriers < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_couriers do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
