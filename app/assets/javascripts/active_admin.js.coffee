#= require active_admin/base
#= require chosen.jquery.min
$ ->
  # enable chosen js
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
