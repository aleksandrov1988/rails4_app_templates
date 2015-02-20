$.fn.set_positions = ->
  $(this).find("[data-position]").each (i) ->
    $(this).val i

$ ->
  $(document).on 'click', 'a.remove_fields', ->
    if confirm("Вы уверены?")
      fields=$(this).closest(".fields")
      $(fields).find("input[type=hidden].remove_fields").val "1"
      $(fields).hide()
    false
  $(document).on 'click','a.add_fields', ->
    fieldset=$(this).closest('fieldset')
    new_id = new Date().getTime()
    association=$(this).attr('data-association')
    regexp = new RegExp("new_" + association, "g")
    content=$(this).attr('data-content')
    fieldset.find(".fieldset").append content.replace(regexp, new_id)
    fieldset.set_positions()
    false
