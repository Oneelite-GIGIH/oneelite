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

    it '[model.user.3] is not valid without nama' do
      user = FactoryBot.build(:user, nama: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.4] is not valid without no_hp' do
      user = FactoryBot.build(:user, no_hp: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.5] is not valid without email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.6] is not valid without role' do
      user = FactoryBot.build(:user, role: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.7] is not valid without saldo' do
      user = FactoryBot.build(:user, saldo: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.8] is not valid without alamat' do
      user = FactoryBot.build(:user, alamat: nil)
      expect(user).to_not be_valid
    end

    it '[model.user.9] is not valid if email format is invalid' do
      user = FactoryBot.build(:user, email: "email@@mail")
      expect(user).to_not be_valid
    end

    it '[model.user.10] is not valid if role is invalid' do
      expect { User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 99, saldo: 99.999, alamat: "Test Jalan 2") }.to raise_error(ArgumentError)
    end

    it '[model.user.11] is not valid if saldo is not decimal or number' do
      user = FactoryBot.build(:user, saldo: "$1000")
      expect(user).to_not be_valid
    end

    it '[model.user.12] is not valid if saldo is negative number' do
      user = FactoryBot.build(:user, saldo: -9999)
      expect(user).to_not be_valid
    end
  end
end
