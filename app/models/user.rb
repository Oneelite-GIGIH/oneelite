class User < ApplicationRecord
    enum role: { PENGGUNA: 0, KURIR: 1 }

    validates :nama, presence: true

    validates :no_hp, presence: true

    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Format Email Salah" }

    validates :role, presence: true, inclusion: { in: roles }

    validates :saldo, presence: true, numericality: { greater_than_or_equal_to: 0 }

    validates :alamat, presence: true
end
