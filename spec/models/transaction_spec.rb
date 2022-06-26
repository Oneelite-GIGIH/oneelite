require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'Transaction Model' do
    it '[model.transaction.1] is valid if factory data is valid' do
      transaction = FactoryBot.build(:transaction)
      expect(transaction).to be_valid
    end

    it '[model.transaction.2] is valid with valid transaction data' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: 10000, status: 0)
      transaction.valid?
      expect(transaction).to be_valid
    end

    it '[model.transaction.3] is not valid without user_id' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: nil, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: 10000, status: 0)
      transaction.valid?
      expect(transaction).to_not be_valid
    end

    it '[model.transaction.4] is valid without delivery_courier_id' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      transaction = Transaction.new(user: user, waste: waste, delivery_courier: nil, nominal_dibayar: 10000, status: 0)
      transaction.valid?
      expect(transaction).to be_valid
    end

    it '[model.transaction.5] is not valid without waste_id' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: user, waste: nil, delivery_courier: delivery_courier, nominal_dibayar: 10000, status: 0)
      transaction.valid?
      expect(transaction).to_not be_valid
    end

    it '[model.transaction.6] is not valid if status unknown' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      expect { Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: 10000, status: 99) }.to raise_error(ArgumentError)
    end

    it '[model.transaction.7] is not valid if nominal_dibayar is negative' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: -1000, status: 0)
      transaction.valid?
      expect(transaction).to_not be_valid
    end

    it '[model.transaction.8] is not valid if nominal_dibayar is not number' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: "$1000", status: 0)
      transaction.valid?
      expect(transaction).to_not be_valid
    end

    it '[model.transaction.9] is valid if nominal_dibayar is equal 0' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      delivery_courier = DeliveryCourier.new(user: user)
      transaction = Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: 0, status: 0)
      transaction.valid?
      expect(transaction).to be_valid
    end
  end
end
