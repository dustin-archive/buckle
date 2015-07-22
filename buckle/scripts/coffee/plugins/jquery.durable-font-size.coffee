# Durable Font Size - 1.0.2
# June 23, 2015
# The MIT License (MIT)
# Copyright (c) 2015 Dustin Dowell
# github.com/dustindowell22/durable-font-size
# =============================================


(($) ->
  $.fn.dfs = (drag = 32, precision = 'low', container = 'window', fontSize = null) ->

    # Cache this object
    $this = $(this)

    # Store the font size
    if fontSize == null
      console.log('hello')
      fontSize = parseFloat($this.css('font-size'))

    # Self-initiating Durable Font Size
    do dfs = ->

      #
      containerWidth =
        if container == 'window'
          $(window).width()
        else if container == 'parent'
          parseFloat($this.parent().css('width'))

      #
      fontScale = fontSize + (containerWidth / (drag * fontSize))

      #
      newFontSize =
        if precision == 'low'
          fontScale
        else if precision == 'medium'
          Math.round(fontScale)
        else if precision == 'high'
          Math.round(parseFloat(fontScale / fontSize) * fontSize)
        else
          fontSize

      # Set the font size
      $this.css('font-size', (newFontSize / 16) + 'rem')

    # Execute on resize
    $(window).on('resize orientationchange', dfs)

    # Allow chaining
    return this

) jQuery
