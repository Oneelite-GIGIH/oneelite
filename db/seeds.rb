# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create( nama: "Kurir 1", no_hp: "08123456789", email: "kurir1@oneelite.com", role: 1, alamat: "Rumah 1", password: "12341234" )
DeliveryCourier.create( user_id: user.id )
