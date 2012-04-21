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
      # parse the data
      merchant_data  = {name: row["merchant_name"], address: ["merchant address"]}
      item_data      = {description: row["item description"], price: row["item price"]}
      purchaser_data = {name: row["purchaser name"]}
      purchase_data  = {count: row["purchase count"]}
      
    end
  end
end
