#= require active_admin/base
#= require chosen.jquery.min
$ ->

  $('.chosen-input').chosen
    allow_single_deselect: true
    no_results_text: 'Sin resultados'
    width: "50%"

  load_chosen = ->
    $('.chosen-input').chosen
      allow_single_deselect: true
      no_results_text: 'Sin resultados'
      width: "50%"

  $('.has_many_add').on 'click', ->
    setTimeout load_chosen, 100

  $("#page_stadistic_url_id").chosen
    width: "100%"
