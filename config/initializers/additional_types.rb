ActiveSupport.on_load(:active_record) do
  ActiveModel::Type.register(:array_of_strings, ArrayOfStringsType)
end
