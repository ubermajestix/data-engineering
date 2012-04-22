# This is the person who purchases Items from Merchants.
# Right now they only have a name and a record of their purchases.
class Person < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
