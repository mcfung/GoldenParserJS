helper = require '../src/utils/helper'

exports.helper = {
  setUp: (done) ->
    done()
  tearDown: (done) ->
    done()
  'test extend objects': (test) ->
    result = helper.extend {
                             name: 'name'
                           },
                           {
                             age: 10
                           }
    test.deepEqual result, {name: 'name', age: 10}
    test.done()
}