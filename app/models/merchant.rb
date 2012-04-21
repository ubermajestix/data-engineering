# A Merchant will have an address and a name.
# They will also have Items for sale.
class Merchant < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  # For now the merchant can have one address b/c the data
  # does not dictate that merchants can have multiple locations.
  # We would probably want a MerchantLocation model to support
  # merchants with more than one location. That would also help
  # us find locations near a potenial Purchaser.
  validates :address, presence: true, uniqueness: true
end
