class CreateSubsidiaryData < ActiveRecord::Migration
  def change
    create_table :subsidiary_data do |t|
      t.string :import_data
      t.datetime :started_processing_at
      t.datetime :finished_processing_at
      t.timestamps
    end
  end
end
