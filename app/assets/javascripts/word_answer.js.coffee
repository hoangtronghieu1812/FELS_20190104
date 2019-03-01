jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).closest('fieldset').find(".allow-destroy").val('1')
    $(this).closest('fieldset').find(".word-answer-content").remove()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
