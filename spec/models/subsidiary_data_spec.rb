require 'spec_helper'
require 'carrierwave/test/matchers'

describe SubsidiaryData do

  context "#async_process_import_data" do
    
    subject{Fabricate(:subsidiary_data)}

    it "should enqueue the Resque job" do
      mock(Resque).enqueue(Importer, subject.id){}
      subject.async_process_import_data
    end
  
  end

  context "#processing? and #start_processing" do
    it "should not be processing if started_processing_at is nil" do
      subject.should_not be_processing
    end

    it "should be processing if started_processing_at isn't nil and finished_processing_at is nil" do
      subject.start_processing
      subject.should be_processing
    end
  end

  context "#processed? and #finish_processing" do
    it "should not be processed if finished_processing_at is nil" do
      subject.should_not be_processed
    end

    it "should be processed if finished_processing_at is not null" do
      subject.finish_processing
      subject.should be_processed
    end
  end

  context "storing a file" do
    include CarrierWave::Test::Matchers
  
    let(:file_path){Rails.root.join("spec/fixtures/example_input.tab")}

    it "should be easy" do
      subject.import_data = File.open(file_path)
      subject.save
      subject.import_data.current_path.should be_identical_to file_path
    end
  end
end
