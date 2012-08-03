factorial_js = require "./factorial_js"
# factorial_cc = require "./factorial_cc"
# factorial_eio = require "./factorial_eio"

utils = require "./utils"

NUMBER = 5000
LOOP = 100000

console.time "JavaScript Time: "
# console.log "JavaScript Result: #{factorial_js.factorial(NUMBER)}"
factorial_js.factorial(NUMBER)
console.timeEnd "JavaScript Time: "


# console.time "C++ Time: "
# # console.log "C++ Result: #{factorial_cc.factorial(NUMBER)}"
# for i in [0...LOOP]
#   factorial_cc.factorial(NUMBER)
# console.timeEnd "C++ Time: "
#
#
# loopFn = (v, i, iterFn) -> factorial_eio.factorial NUMBER, iterFn
# doneFn = -> console.timeEnd "C++ Async Real Time: "
# console.time "C++ Async Time: "
# # factorial_eio.factorial NUMBER, (result) -> console.log "C++ Async Result: #{result}"
# console.time "C++ Async Real Time: "
# utils.asyncParForEach [0...LOOP], loopFn, doneFn
# console.timeEnd "C++ Async Time: "
