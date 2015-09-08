# Element Catch - 1.0.6
# June 20, 2015
# The MIT License (MIT)
# Copyright (c) 2015 Dustin Dowell
# github.com/dustindowell22/element-catch
# ==============================================


(($) ->
  $.fn.elementCatch = (scrollClass = 'scrolled') ->

    # Cache this object
    $this = $(this)

    # Distance from top of document
    distanceTop = $this.offset().top

    # Self-initiating Element Catch
    do elementCatch = ->

      # Scrollbar distance from top of document
      scrollPosition = $(document).scrollTop()

      # Add class if scroll position is larger than distance from top of document
      if scrollPosition > distanceTop
        if not $this.hasClass(scrollClass)
          $this.addClass(scrollClass)
      else
        $this.removeClass(scrollClass)

    # Call on events
    $(window).on('scroll resize orientationchange', elementCatch)

    # Allow chaining
    return this

) jQuery
