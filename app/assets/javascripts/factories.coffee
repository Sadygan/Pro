$(document).ready ->
  $('table').on 'show.bs.collapse', '.collapse', (e) ->
    actives = $('table').find('.in, .collapsing')
    actives.each (index, element) ->
      $(element).collapse 'hide'
      return
    return
  return