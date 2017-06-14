# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class SOLR.SearchPage
  constructor: (@container,@facetName,@url,@facetType = 'checkbox') ->
    @init()


  init: ->
    #the events for checkboxes of facet
    @searchFormObject = {}
    @searchFormObject[@facetName] = []
    @container.find(".facet-check-box-#{@facetName}").click (e)=>
      @searchFormObject[@facetName]= [] if @facetType == 'radio'
      if e.target.checked
        @searchFormObject[@facetName].push(e.target.value)
      else
        index = @searchFormObject[@facetName].indexOf(e.target.value)
        @searchFormObject[@facetName].splice index, 1
      @filterSearch()

  filterSearch: ->
     data = @container.find('#search-form').serializeArray()
     $.each data, (i, v) =>
       @searchFormObject[v.name] = v.value
     @searchFormObject['facet_call'] = true
     #Now that the form data is ready make an AJAX call to the search players
     $.ajax
        type: "POST"
        url: @url
        data: @searchFormObject
        success: (data, textStatus, jqXHR) =>
            @container.find('.search-results-container').html(data)
        error: (jqXHR, textStatus, errorThrown) ->
            alert(message: jqXHR.responseJSON.message)










