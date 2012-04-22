Fabricator(:purchase) do
  person! {Fabricate(:person)}
  item! {Fabricate(:item)}
end
