# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load", ->
  $("#article_keyword").select2 tags: []
  return

$(document).on "ready page:load", ->
  $("#article_tag_list").each ->
    placeholder = $(this).data("placeholder")
    url = $(this).data("url")
    saved = $(this).data("saved")
    $(this).select2
      tags: true
      placeholder: placeholder
      minimumInputLength: 1
      initSelection: (element, callback) ->
        saved and callback(saved)
        return

      ajax:
        url: url
        dataType: "json"
        data: (term) ->
          q: term

        results: (data) ->
          results: data

      createSearchChoice: (term, data) ->
        if $(data).filter(->
          @name.localeCompare(term) is 0
        ).length is 0
          
          name: term

      formatResult: (item, page) ->
        item.name

      formatSelection: (item, page) ->
        item.name

    return

  return