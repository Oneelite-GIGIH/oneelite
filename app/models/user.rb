class User < ApplicationRecord

    has_many :wastes, class_name: "waste", foreign_key: "reference_id"
    has_many :transactions, class_name: "transactions", foreign_key: "reference_id"
    has_one :delivery_courier, class_name: "delivery_courier", foreign_key: "delivery_courier_id"
    enum role: { PENGGUNA: 0, KURIR: 1 }
    before_save { self.email = email.downcase }
    validates :nama, presence: true, length: { maximum: 50 }
    validates :no_hp, presence: true
    validates :email, presence: true,   length: { maximum: 255 }, 
                                        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Format Email Salah" },
                                        uniqueness: true

    validates :role, presence: true, inclusion: { in: roles }
    validates :saldo, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :alamat, presence: true

    has_secure_password
end
