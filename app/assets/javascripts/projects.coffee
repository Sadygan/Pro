$(document).ready ->
  $('table .collapse').on 'show.bs.collapse', (e) ->
    actives = $('table').find('.in, .collapsing')
    actives.each (index, element) ->
      $(element).collapse 'hide'
      return
    return
  return