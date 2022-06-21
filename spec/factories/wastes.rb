FactoryBot.define do
  factory :waste do
    user
    jenis_sampah { Faker::Food.dish }
    berat { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
    gambar { Faker::File.file_name(dir: 'waste/images', ext: ['png', 'jpeg', 'jpg']) }
    alamat_penjemputan { "Alamat Default" }
  end
end
