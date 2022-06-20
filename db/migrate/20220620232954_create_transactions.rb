class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :waste, null: false, foreign_key: true
      t.decimal :nominal_dibayar
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
