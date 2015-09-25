postcss = require('postcss')

split_root = require('./split_root')

module.exports = postcss.plugin 'presass_lifesaver', ->
  return (css, result) ->
    css.walkDecls (decl) ->
      css_mixins = [
        'border-width'
        'border-radius'

        'margin'
        'margin-top'
        'margin-right'
        'margin-bottom'
        'margin-left'

        'padding'
        'padding-top'
        'padding-right'
        'padding-bottom'
        'padding-left'

        'position'

        'width'
        'min-width'
        'max-width'

        'height'
        'min-height'
        'max-height'

        'font-size'
        'line-height'
      ]

      ls_mixins = [
        'radius'

        'position-absolute'
        'position-fixed'
        'position-relative'
        'position-static'
        'position-sticky'

        'absolute'
        'fixed'
        'relative'
        'static'
        'sticky'

        'position-inherit'
        'position-initial'
        'position-unset'

        'size'
        'min-size'
        'max-size'
      ]

      arg_list = split_root(/\s*\(\s*/, /\s*\)\s*/, /\s*,\s*/, decl.value)
      value_list = split_root(/\s*\(\s*/, /\s*\)\s*/, /\s+/, arg_list[0])

      for mixin in ls_mixins
        if mixin == decl.prop
          decl.prop = '@include ' + decl.prop
          decl.value = '(' + decl.value + ')'
          decl.raws.between = ''

      for mixin in css_mixins
        if mixin == decl.prop
          if arg_list.length > 1
            if value_list.indexOf('x') == -1 || value_list.indexOf('null') == -1
              if value_list.length == 1
                decl.value = arg_list[1] + '(' + arg_list[0] + ')'
              else
                decl.prop = '@include ' + decl.prop
                decl.value = '(' + decl.value + ')'
                decl.raws.between = ''
