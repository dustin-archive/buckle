(($) ->
  $.fn.toggle = (target, toggleClass = 'toggled') ->

    # Cache this object
    $this = $(this)

    #
    if target
      $target = $(target)
    else
      $target = $this

    #
    $this.click (event) ->
      $target.toggleClass(toggleClass)

    #
    $(document).on 'click focusin', (event) ->
      if not $(event.target).closest($this.parent()).length
        $target.removeClass(toggleClass)

    # Allow chaining
    return this

) jQuery
