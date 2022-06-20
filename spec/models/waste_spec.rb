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
  end
end
