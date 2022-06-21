require 'rails_helper'

RSpec.describe DeliveryCourier, type: :model do
  context 'Delivery Courier Model' do
    it '[model.delivery_courier.1] is valid if factory data is valid' do
      delivery_courier = FactoryBot.build(:delivery_courier)
      expect(delivery_courier).to be_valid
    end

    it '[model.delivery_courier.2] is valid with valid delivery courier data' do
      user = FactoryBot.build(:user)
      delivery_courier = DeliveryCourier.new(user: user)
      delivery_courier.valid?
      expect(delivery_courier).to be_valid
    end

    it '[model.delivery_courier.3] is not valid without user reference' do
      delivery_courier = DeliveryCourier.new(user: nil)
      delivery_courier.valid?
      expect(delivery_courier).to_not be_valid
    end
  end
end
