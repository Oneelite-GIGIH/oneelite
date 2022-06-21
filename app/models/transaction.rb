class Transaction < ApplicationRecord
  belongs_to :user

  belongs_to :waste

  belongs_to :delivery_courier
end
