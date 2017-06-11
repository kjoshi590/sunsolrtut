# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class ECLT.SearchPage
  constructor: (@container) ->
    @init()

  init: ->
    #the events for checkboxes of facet
    @container.find('.facet-check-box').click (e)=>
      @filterSearch()
    @container.find(".facet-reset").addClass('hidden') unless  @container.find(".#{@facetName}-list").find("input:checked").length > 0





