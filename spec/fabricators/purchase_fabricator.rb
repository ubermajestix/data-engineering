Fabricator(:purchase) do
  purchaser! {Fabricate(:purchaser)}
  item! {Fabricate(:item)}
end
