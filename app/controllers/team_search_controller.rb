class TeamSearchController < ApplicationController

  before_action :set_sort_params, only: [:search_teams]


  def new_search_team

  end

  def search_teams

      @search =  Team.search() do |searcher|

        searcher.fulltext search_params[:term] do
            fields(:name,:city,:club_name => 2.0)
          end
        searcher.with(:city,'London') if search_params[:london_only] == 'true'
        searcher.with(:city, params[:city]) if params[:city].present?
        #searcher.order_by params[:sort_by], params[:sort_direction]
        searcher.facet(:city)
      end
      @teams,@total = @search.results, @search.total

      if params[:facet_call].present?
        render 'team_search/team_search_results', layout: false
      else
        render 'team_search/new_search_team'
      end
  end

  def set_sort_params
    params[:sort_by] = (params[:sort_by] || 'club_name')
    params[:sort_direction] = (params[:sort_direction] || 'asc')
  end

  def search_params
    params.permit( :term, :london_only, :city, :authenticity_token)
  end
end
