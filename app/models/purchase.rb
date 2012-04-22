# This is a record of Items purchased by Purchasers.
# We will use this class to caclulate the gross revenue of all
# purchases.
class Purchase < ActiveRecord::Base
  belongs_to :purchaser
  validates :purchaser_id, presence: true
  belongs_to :item
  validates :item_id, presence: true
end
