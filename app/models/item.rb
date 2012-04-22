# An item a Merchant has for sale. This will include a description and a
# price.
class Item < ActiveRecord::Base
  # TODO in a real world scenario we should scope the uniqueness 
  # contraint to a merchant b/c different merchants could have the
  # same description.
  validates :description, presence: true, uniqueness: true
  
  belongs_to :merchant
  validates  :merchant_id, presence: true
  
  # From: https://github.com/RubyMoney/money
  composed_of :price,
  :class_name => "Money",
  :mapping => [%w(price_in_cents cents), %w(currency currency_as_string)],
  :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
  :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }
end
