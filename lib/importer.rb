# This class is responsible for creating all the objects in the database
# given an Upload object. It will also be responsible for recording when
# the Upload started being processed and when it finished.
#
# This should really be run in the background. The data in this example
# is probably unrepresentative and I would assume the data needing to be
# imported is going to be much larger and take a signicant amount of
# time to process.
# Thus, I will use Resque to process the import tasks in the background.
class Importer
  @queue = "importer"
  def self.perform(upload_id)
    upload = Upload.find(upload_id)
    process_csv(upload.import_data_file_name)
  end

  def self.process_csv(path_to_import_data)
    CSV.foreach(path_to_import_data, col_sep: "\t", headers: true) do |row|
      # Parse data from the row
      merchant_data  = {name: row["merchant_name"], address: ["merchant address"]}
      item_data      = {description: row["item description"], price: row["item price"]}
      purchaser_data = {name: row["purchaser name"]}
      purchase_count  = row["purchase count"]
      
    end
  end
  
  # Errors could creep up if data was blank and we had merchants with
  # multiple addresses. If the address field in that scenario was blank
  # we could select the wrong merchant b/c we would look them up by name
  # and grab the first one which could be the incorrect.
  # Why did this company not use ids? Why are there no primary keys? 
  # Who was doing technical due diligence? Gah!
  #
  # However, given the validations on merchant that require a name and
  # address I'm confident this code will work given the example data.
  # 
  # Find a merchant by name and address.
  # If no merchants are found create one.
  # Returns a Merchant.
  # Raises ActiveRecord::RecordInvalid if name or address are nil.
  def self.create_merchant(attrs)
    merchant = Merchant.where(attrs).first
    merchant = Merchant.create!(attrs) unless merchant
    merchant
  end
  
  # Search for item by merchant and description
  # If no item is found create one.
  # Returns an Item
  # Raises ActiveRecord::RecordInvalid if description, merchant, or
  # price are nil.
  def self.create_item(merchant, attrs)
    item = Item.where(merchant_id: merchant, description: attrs[:description]).first
    item = Item.create!(attrs.merge(merchant_id: merchant)) unless item
    item
  end
  
  # Search for purchaser by name.
  # If one isn't found, one will be created for you.
  # Returns a Purchaser
  # Raises ActiveRecord::RecordInvalid if name is nil.
  def self.create_purchaser(attrs)
    purchaser = Purchaser.where(attrs).first
    purchaser = Purchaser.create!(attrs) unless purchaser
    purchaser
  end

  def self.create_purchases(purchaser, item, count)

  end 

end
