class HelloWorldJs

  constructor: ->
    @m_count = 0

  hello: ->
    @m_count++
    "Hello World"

exports.HelloWorldJs = HelloWorldJs
