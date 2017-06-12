# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class SOLR.SearchPage
  constructor: (@container) ->
    @init()


  init: ->
    #the events for checkboxes of facet
    @searchFormObject = {}
    @searchFormObject['position'] = []
    @container.find('.facet-check-box').click (e)=>
      if e.target.checked
        @searchFormObject['position'].push(e.target.value)
      else
        index = @searchFormObject['position'].indexOf(e.target.value)
        @searchFormObject['position'].splice index, 1
      @filterSearch()

  filterSearch: ->
     data = @container.find('#search-players-form').serializeArray()
     $.each data, (i, v) =>
       @searchFormObject[v.name] = v.value
     @searchFormObject['facet_call'] = true
     #Now that the form data is ready make an AJAX call to the search players
     $.ajax
        type: "POST"
        url: "/search"
        data: @searchFormObject
        success: (data, textStatus, jqXHR) =>
            @container.find('.player-search-results-container').html(data)
        error: (jqXHR, textStatus, errorThrown) ->
            alert(message: jqXHR.responseJSON.message)










