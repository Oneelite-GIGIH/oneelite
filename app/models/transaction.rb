class Transaction < ApplicationRecord
  belongs_to :user

  belongs_to :waste

  belongs_to :delivery_courier, optional: true

  enum status: { NEW: 0, DELIVERED: 1, PAID: 2, CANCELLED: 3 }

  validates :user, presence: true

  validates :waste, presence: true

  validates :delivery_courier, presence: false

  validates :nominal_dibayar, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :status, presence: true, inclusion: { in: statuses }
end
