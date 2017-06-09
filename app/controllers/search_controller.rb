class SearchController < ApplicationController

  include Pagination
  before_action :paginate_params, only: [:search_players]

  def search

  end

  def search_players
    page = @page
    limit = @limit
    search =  Player.search do |searcher|
      searcher.fulltext search_params[:term] if search_params[:term].present?
      searcher.with(:position, "FWD") if search_params[:only_forward] == 'true'
      searcher.paginate :page => page, :per_page => limit
    end
    @players,@total, @total_pages = search.results, search.total, search.results.total_pages

    render 'search/search'
  end


  def search_params
    params.permit( :term, :position, :country, :only_forward)
  end

end
