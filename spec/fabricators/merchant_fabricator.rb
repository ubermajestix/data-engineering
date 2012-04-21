Fabricator(:merchant) do
  name {Faker::Company.name}
  address {"#{rand(100)} #{Faker::Address.street_name}"}
end
