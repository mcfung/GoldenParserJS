extend = exports.extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object