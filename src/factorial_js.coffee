factorial = (n) ->
  if n <= 1 then 1 else n + factorial(n - 1)

exports.factorial = factorial
