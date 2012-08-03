f = (n) ->
  if n <= 1 then 1 else n + f(n - 1)

factorial = (n) ->
  r = 0
  for i in [0...100000]
    r = f(n)
  r

exports.factorial = factorial
