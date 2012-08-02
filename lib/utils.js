// Generated by CoffeeScript 1.3.3
(function() {
  var asyncParForEach, breaker;

  breaker = typeof StopIteration === 'undefined' ? '__break__' : StopIteration;

  /*
  Asynchronous parallel version of Array.prototype.forEach
  
  @param  {Array}     array     the array to iterate over
  @param  {Function}  iterator  the function to apply to each item in the array,
                                function has three argument, the first is the item
                                value, the second is the item index, the third is
                                a callback function
  @param  {Function}  fn        the function to call when the forEach has ended
  */


  asyncParForEach = function(array, iterator, fn, context) {
    var done, doneFn, i, len, v, _i, _len;
    done = 0;
    len = array.length;
    if (array.length === 0) {
      fn();
    }
    doneFn = function(error, result) {
      done++;
      if (done === len && fn) {
        return fn(error, result);
      }
    };
    try {
      for (i = _i = 0, _len = array.length; _i < _len; i = ++_i) {
        v = array[i];
        iterator.call(context, v, i, doneFn, array);
      }
    } catch (e) {
      if (e !== breaker) {
        throw e;
      }
    }
    return array;
  };

  exports.asyncParForEach = asyncParForEach;

}).call(this);