require 'faker'
Customer.delete_all; Invoice.delete_all
100.times do
  c = Customer.create!(:name=>Faker::Name.name,
                      :street_address=>Faker::Address.street_address,
                      :city=>Faker::Address.city, :zip=>Faker::Address.zip_code,
                      :state=>Faker::Address.us_state,
                      :phone_number=>Faker::PhoneNumber.phone_number)
  rand(10).times do
    c.invoices.create!(:due_on=>(Date.today + (rand(200) - 170)),
                      :amount=>(rand(1000)+25))
  end
end

