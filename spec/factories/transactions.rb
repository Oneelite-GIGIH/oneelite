FactoryBot.define do
  factory :transaction do
    user
    waste
    nominal_dibayar { Faker::Number.decimal(l_digits: 2, r_digits: 3) }
    status { 0 }
  end
end
