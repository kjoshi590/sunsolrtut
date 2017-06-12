# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class SearchPage
  constructor: (@container) ->
    @init()

  init: ->
    #the events for checkboxes of facet
    @container.find('.facet-check-box').click (e)=>
      @filterSearch()

  filterSearch: ->
     debugger
     data = getFormData()

  getFormData:  ->
    unindexed_array = @container.find('#search-players-form').serializeArray()
    indexed_array = {}
    $.map unindexed_array, (n, i) ->
      indexed_array[n['name']] = n['value']
      return indexed_array






