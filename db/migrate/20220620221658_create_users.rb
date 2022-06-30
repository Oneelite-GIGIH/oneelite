class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nama
      t.string :no_hp
      t.string :email
      t.integer :role, default: 0
      t.decimal :saldo, default: 0
      t.text :alamat

      t.timestamps
    end
  end
end
