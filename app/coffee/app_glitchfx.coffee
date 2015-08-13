class GlitchFX

  'use strict'

  @canvas
  @context
  @img
  @offset = undefined
  @w = undefined
  @h = undefined
  @glitchInterval = undefined

  constructor: (id, src)->
    id = if id then id else 'glitch_canvas'
    src = if src then src else '/images/logo.png'
    @img = new Image
    @img.src = src
    @canvas = document.getElementById id
    @context = @canvas.getContext '2d'

    @img.onload = =>
      @glitching()

      return

    return

  glitching: ->
    @canvas.width = @w = $(window).width()
    @offset = @w * .1
    @canvas.height = @h = ~ ~(175 * (@w - (@offset * 2)) / @img.width)
    $(window).resize =>
      @canvas.width = @w = $(window).width()
      @offset = @w * .1
      @canvas.height = @h = ~ ~(175 * (@w - (@offset * 2)) / @img.width)

      return

    clearInterval @glitchInterval
    @glitchInterval = setInterval =>
      @clear()
      @context.drawImage @img, 0, 110, @img.width, 175, @offset, 0, @w - (@offset * 2), @h
      setTimeout =>
        @glitchImg(@context, @canvas)

        return
      , @randInt(250, 1000)

      return
    , 500

    return

  glitchImg: (context, canvas)->
    i = 0
    a = @randInt(1, 13) # ~ ~(Math.random() * (13 - 1) + 1)
    b = @randInt(5, @h / 3) #~ ~(Math.random() * (@h / 3 - 5) + 5)
    while i < a
      x = Math.random() * @w
      y = Math.random() * @h
      spliceWidth = @w - x
      spliceHeight = b
      context.drawImage canvas, 0, y, spliceWidth, spliceHeight, x, y, spliceWidth, spliceHeight
      context.drawImage canvas, spliceWidth, y, x, spliceHeight, 0, y, x, spliceHeight
      i++

    return

  randInt: (a, b) ->
    ~ ~(Math.random() * (b - a) + a)

  clear: ->
    @context.rect 0, 0, @w, @h
    @context.fill()

    return

