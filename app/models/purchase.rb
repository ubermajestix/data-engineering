# This is a record of Items purchased by People.
# We will use this class to caclulate the gross revenue of all
# purchases.
class Purchase < ActiveRecord::Base
  belongs_to :person
  validates :person_id, presence: true
  belongs_to :item
  validates :item_id, presence: true
end
