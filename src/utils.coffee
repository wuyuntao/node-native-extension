# Establish the object that gets thrown to break out of a loop iteration.
# `StopIteration` is SOP on Mozilla.
breaker = if typeof(StopIteration) is 'undefined' then '__break__' else StopIteration

###
Asynchronous parallel version of Array.prototype.forEach

@param  {Array}     array     the array to iterate over
@param  {Function}  iterator  the function to apply to each item in the array,
                              function has three argument, the first is the item
                              value, the second is the item index, the third is
                              a callback function
@param  {Function}  fn        the function to call when the forEach has ended
###
asyncParForEach = (array, iterator, fn, context) ->
  done = 0
  len = array.length
  fn() if array.length == 0
  doneFn = (error, result) ->
    done++
    fn(error, result) if done == len and fn
  try
    iterator.call(context, v, i, doneFn, array) for v, i in array
  catch e
    throw e if e isnt breaker
  array

exports.asyncParForEach = asyncParForEach
