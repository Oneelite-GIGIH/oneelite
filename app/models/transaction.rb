class Transaction < ApplicationRecord
  belongs_to :user

  belongs_to :waste

  belongs_to :delivery_courier

  enum status: { NEW: 0, DELIVERED: 1, PAID: 2, CANCELLED: 3 }

  validates :user, presence: true

  validates :waste, presence: true

  validates :delivery_courier, presence: true

  validates :nominal_dibayar, presence: true, numericality: { greater_than: 0 }

  validates :status, presence: true, inclusion: { in: statuses }
end
