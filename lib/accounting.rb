# This class's goal is to return the gross revenue given a set of purchases.
# This class could include, as requirements change, methds that calculate more 
# metrics about purchases like average spend per purchase or gross profit.

class Accounting
  # An Array of Purchase objects
  attr_reader :purchases
  attr_accessor :revenue
  def initialize(purchases)
    @purchases = purchases
  end
  
  # Calculates the total revenue of from purchases.
  # Retunrs a Money object
  def calculate_revenue
    @revenue = purchases.inject(Money.new(0)){|revenue, purchase| revenue += purchase.price_paid; revenue} 
  end
  
  # Returns the revenue formatted in dollars as a String
  def display_revenue
    calculate_revenue if revenue.nil?
    sprintf("$%.2f", revenue.dollars)
  end
end
