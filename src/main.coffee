factorial_js = require "./factorial_js"
factorial_cc = require "./factorial_cc"
factorial_eio = require "./factorial_eio"

NUMBER = 1000

console.time "JavaScript Time: "
factorial_js.factorial(NUMBER)
console.timeEnd "JavaScript Time: "


console.time "C++ Time: "
console.log "C++ Result: #{factorial_cc.factorial(NUMBER)}"
factorial_cc.factorial(NUMBER)
console.timeEnd "C++ Time: "


console.time "C++ Async Time: "
console.time "C++ Async Real Time: "
factorial_eio.factorial NUMBER, (result) ->
 console.timeEnd "C++ Async Real Time: "
 console.timeEnd "C++ Async Time: "
