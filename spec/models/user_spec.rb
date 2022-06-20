require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User Model' do
    it '[model.user.1] is valid if factory data is valid' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it '[model.user.2] is valid with valid user data' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      user.valid?
      expect(user).to be_valid
    end
  end
end
