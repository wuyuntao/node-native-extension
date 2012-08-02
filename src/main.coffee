factorial_js = require "./factorial_js"
factorial_cc = require "./factorial_cc"
factorial_eio = require "./factorial_eio"

NUMBER = 5000
LOOP = 100000
FN = ->

console.time "JavaScript Time: "
for i in [0...LOOP]
  factorial_js.factorial(NUMBER)
console.log "JavaScript Result: #{factorial_js.factorial(NUMBER)}"
console.timeEnd "JavaScript Time: "

console.time "C++ Time: "
for i in [0...LOOP]
  factorial_cc.factorial(NUMBER)
console.log "C++ Result: #{factorial_cc.factorial(NUMBER)}"
console.timeEnd "C++ Time: "

console.time "C++ Async Time: "
factorial_eio.factorial NUMBER, (result) ->
  console.log "C++ Async Result: #{result}"
for i in [0...LOOP]
  factorial_eio.factorial NUMBER, FN
console.timeEnd "C++ Async Time: "
