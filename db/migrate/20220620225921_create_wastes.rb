class CreateWastes < ActiveRecord::Migration[7.0]
  def change
    create_table :wastes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :jenis_sampah
      t.float :berat
      t.text :gambar
      t.text :alamat_penjemputan

      t.timestamps
    end
  end
end
