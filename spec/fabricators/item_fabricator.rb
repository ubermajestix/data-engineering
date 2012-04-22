Fabricator(:item) do
  price_in_cents{(rand(100)*100)+100}
  description {|item| "$#{item.price.to_s} for #{Faker::HipsterIpsum.word} classes"}
  merchant! {Fabricate(:merchant)}
end
