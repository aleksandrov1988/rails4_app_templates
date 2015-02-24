ready = ->
  $("#sidebar-toggle").on 'click', ->
    id=$(this).attr 'href'
    $(id).toggleClass 'toggled'
    false

$(document).ready ready
$(document).on 'page:load', ready