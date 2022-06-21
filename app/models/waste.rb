class Waste < ApplicationRecord
  belongs_to :user

  has_many :transactions, class_name: "transaction", foreign_key: "reference_id"

  validates :jenis_sampah, presence: true

  validates :berat, presence: true, numericality: { greater_than: 0 }

  validates :gambar, presence: true

  validates :alamat_penjemputan, presence: true
end
