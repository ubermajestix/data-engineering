require 'spec_helper'
require 'carrierwave/test/matchers'

describe Upload do
  include CarrierWave::Test::Matchers
  
  let(:file_path){Rails.root.join("spec/fixtures/example_input.tab")}
  let(:uploader){Upload.new(Object.new, :import_data)}

  it "should store a file" do
    uploader.store!(File.open(file_path))
    uploader.current_path.should be_identical_to file_path
  end
end
