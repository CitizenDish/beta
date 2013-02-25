class Timer
  constructor : (@tick, @context = @) ->
    @interval   =   1000
    @enable     =   false
    @timerId    =   0

  start       : ->
    @enable     =   true
    fn = =>
      if @enable then @tick.apply(@context)
    @timerId    =   setInterval fn, @interval

  stop        : ->
    @enable     =   false
    clearInterval @timerId

CitizenDish.Modules['timer'] = Timer