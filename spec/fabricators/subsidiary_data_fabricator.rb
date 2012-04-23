Fabricator(:subsidiary_data) do
  import_data {File.open(Rails.root.join("spec/fixtures/example_input.tab"))}
end
