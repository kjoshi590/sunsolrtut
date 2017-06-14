class SearchController < ApplicationController

  include Pagination
  before_action :paginate_params, only: [:search_players]
  before_action :set_sort_params, only: [:search_players]
  before_action :set_query_facet_params, only: [:search_players]

  def new_search

  end

  def search_players
    page = @page
    limit = @limit
    @search =  Player.search(include: [:team,:player_statistic]) do |searcher|
      fields = [:name, :club_name]
        searcher.any do
          fulltext search_params[:term], :fields => fields
        end
      searcher.with(:minutes_played).greater_than(100) if search_params[:active_only] == 'true'
      searcher.with(:position, params[:position]) if params[:position].present?
      searcher.with(:goals_scored, params[:goals_scored]) if params[:goals_scored].present?
      searcher.order_by params[:sort_by], params[:sort_direction]
      #this is field facet
      searcher.facet(:position)
      #this is query facet
      searcher.facet(:goals_scored) do
        row(0..10) do
          with(:goals_scored, 0..10)
        end
        row(11..20) do
          with(:goals_scored, 11..20)
        end
        row(21..30) do
          with(:goals_scored, 21..30)
        end
      end


      searcher.paginate :page => page, :per_page => limit
    end
    @players,@total, @total_pages = @search.results, @search.total, @search.results.total_pages
    if params[:facet_call].present?
      render 'search/search_results', layout: false
    else
      render 'search/new_search'
    end
  end




  def set_sort_params
    params[:sort_by] = (params[:sort_by] || 'name')
    params[:sort_direction] = (params[:sort_direction] || 'asc')
  end

  def set_query_facet_params
    if params[:goals_scored].present?
      case params[:goals_scored][0]
             when "0..10"
               params[:goals_scored] = 0..10
             when "11..20"
               params[:goals_scored] = 11..20
             when "21..30"
               params[:goals_scored] = 21..30
      end
    end
  end

  def search_params
    params.permit( :term, :position, :country, :active_only, :authenticity_token)
  end

end
