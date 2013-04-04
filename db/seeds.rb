require 'faker'

10.times do 
  User.create({ user_name: Faker::Internet.user_name,
                password: Faker::Address.zip_code})
end