$(document).on 'turbolinks:load', ->
  $('#ajax_form').on 'ajax:success', (e. data) ->
    $('#result').empty()
    $.each data, ->
      $
