extend = exports.extend = (target, sources...) ->

  if !sources || sources.length is 0
    return target

  if !target
    target = {}

  [source, nextIterationSources...] = sources
  for own key, val of source
    target[key] = val

  extend.apply(@, [target].concat(nextIterationSources))

exports.getImageSourceFromAlt = ($img) ->

  imageSrc = $img.attr 'alt'
  imageSrc = imageSrc.substring imageSrc.indexOf(']') + 1, imageSrc.lastIndexOf('[')