# Drop Down - 1.0.4
# September 2, 2015
# The MIT License (MIT)
# Copyright (c) 2015 Dustin Dowell
# github.com/dustindowell22/drop-down
# ==============================================


(($) ->
  $.fn.dropDown = (toggleClass = 'toggled') ->

    # Cache this object
    $this = $(this)

    #
    $ul = $this.find('ul')
    $li = $this.find('li')
    $a  = $this.find('a')

    #
    $button   = $ul.siblings($a) # Buttons are anchors that are siblings to an unordered-list
    $parent   = $a.closest($li)  # Parents are list-items that are parents to anchors
    $drawer   = $a.siblings($ul) # Drawers are unordered-lists that are siblings to anchors
    $link     = $a.not($button)  # Links are anchors that are not buttons
    $listItem = $li.has($a)      # List-items contain anchors

    #
    $button.click (event) ->
      event.preventDefault()

      # Cached object names in this function are preceded by a 'c'
      $cButton         = $(this)
      $cParent         = $cButton.parent()
      $cUncle          = $cParent.siblings()
      $cCousin         = $cUncle.find($li)
      $cDrawer         = $cButton.siblings($ul)
      $cDrawerListItem = $cDrawer.find($listItem) # These variable names kinda suck
      $cNestedDrawer   = $cDrawer.find($drawer)   # These variable names kinda suck

      #
      if $cParent.hasClass(toggleClass)
        $cParent.removeClass(toggleClass)
        $cDrawer.css('height', '')
      else
        $cParent.addClass(toggleClass)

      # Reset children
      if $cDrawerListItem.hasClass(toggleClass)
        $cDrawerListItem.removeClass(toggleClass)
        $cNestedDrawer.css('height', '')

      # Reset uncles
      if $cUncle.hasClass(toggleClass)
        $cUncle.removeClass(toggleClass)
        $cUncle.children($drawer).css('height', '')

        # Reset cousins
        if $cCousin.hasClass(toggleClass)
          $cCousin.removeClass(toggleClass)
          $cCousin.children($drawer).css('height', '')

      # Animate auto
      $drawer.update().reverse().each ->

        # Cached object names in this function are preceded by an 'a'
        $aDrawer = $(this)
        $aParent = $aDrawer.parent()

        if $aParent.hasClass(toggleClass)
          $aClone = $aDrawer.clone().css('display', 'none').appendTo($aParent)
          height = $aClone.css('height', 'auto').outerHeight() + 'px'
          $aClone.remove()
          $aDrawer.css('height', '').css('height', height)

    #
    closeMenu = ->
      if $parent.hasClass(toggleClass)
        $parent.removeClass(toggleClass)
        $drawer.css('height', '')

    #
    $link.click ->
      closeMenu()

    #
    $(document).on 'click focusin', (event) ->
      if not $(event.target).closest($button.parent()).length
        closeMenu()

    # Allow chaining
    return this

) jQuery
