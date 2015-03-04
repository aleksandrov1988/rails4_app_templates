ready = ->
  $(".growl-msg").each ->
    type=$(this).data('type') || 'info'
    $.growl $(this).html(),
      type: type
$(document).ready ready
$(document).on 'page:load', ready