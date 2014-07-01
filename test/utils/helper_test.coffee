helper = require '../../src/utils/helper'

exports.helper =
  'test extend objects': (test) ->
    result = helper.extend {
        name: 'name'
      },
      {
        age: 10
      }
    test.deepEqual result, {name: 'name', age: 10}
    test.done()
  'test null target': (test) ->
    result = helper.extend(null, {
      name: 'name'
    })

    test.deepEqual result, {name: 'name'}
    result = helper.extend(undefined, {
      name: 'name'
    })

    test.deepEqual result, {name: 'name'}
    test.done()

  'test no extendee': (test) ->
    result = helper.extend({name: 'name'})
    test.deepEqual result, {name: 'name'}
    test.done()