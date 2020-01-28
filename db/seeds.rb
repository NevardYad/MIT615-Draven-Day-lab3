require 'faker'
for i in 1..24
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = Faker::Internet.free_email(name:name)

  user = User.new
  user.email = email
  user.first_name = first_name
  user.last_name = last_name
  user.street_address = Faker::Address.street_address
  user.city = Faker::Address.city
  user.province = Faker::Address.state
  user.postal_code = Faker::Address.postcode
  user.country = Faker::Address.country
  if user.save
    for ii in 1..24
      micropost = Micropost.new
      micropost.user = user
      micropost.message = Faker::Lorem.paragraph
      micropost.save
    end
  end
end