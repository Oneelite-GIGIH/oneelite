require 'rails_helper'

RSpec.describe Waste, type: :model do
  context 'Waste Model' do
    it '[model.waste.1] is valid if factory data is valid' do
      waste = FactoryBot.build(:waste)
      expect(waste).to be_valid
    end

    it '[model.waste.2] is valid with valid waste data' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to be_valid
    end

    it '[model.waste.3] is not valid without user reference' do
      waste = Waste.new(user: nil, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.4] is not valid without jenis_sampah' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: nil, berat: 3, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.5] is not valid without berat' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: nil, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.6] is not valid without gambar' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: nil, alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.7] is not valid without alamat_penjemputan' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: nil)
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.8] is not valid if berat is not float or number' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: "3 kg", gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.9] is not valid if berat is less than 0' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: -3, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to_not be_valid
    end

    it '[model.waste.10] is valid if berat is in float and less than 1' do
      user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 0.333, gambar: "/waste/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      waste.valid?
      expect(waste).to be_valid
    end
  end
end
