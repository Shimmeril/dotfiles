{
  FieldsSubsetOf = fun record_matchee => record_matchee
    |> std.record.fields
    |> std.array.fold_left (fun contract field => contract & { "%{field}" | optional }) {}
  ,
}
