FactoryBot.define do
  factory :user do
    nama { "Nama Default" }
    no_hp { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.free_email }
    role { 0 }
    saldo { Faker::Number.decimal(l_digits:2, r_digits:3) }
    alamat { "Alamat Default" }
  end
end
