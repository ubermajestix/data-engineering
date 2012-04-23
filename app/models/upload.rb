# This class is responsible for file managment via CarrierWave.
# I chose CarrierWave over Paperclip b/c it does not have a dependency on ImageMagick.
# Also, having a class that only deals with storing and retreiving files
# is handy and doesn't muck up the activerecord class. You know,
# separation of concerns and stuff.
class Upload < CarrierWave::Uploader::Base
  storage :file
end
