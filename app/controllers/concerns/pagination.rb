module Pagination
  include ActiveSupport::Concern

  def paginate_params
    @page = params[:page].blank? || params[:page].to_f.round <= 0  ? 1 : params[:page].to_f.round
    @limit = params[:limit].blank? ? pagination_per_page_limit : params[:limit].to_i
    @limit = @limit == 0? pagination_per_page_limit : @limit
    @filter = params[:filter].blank? ? -1 : params[:filter].to_i
    @offset = (@page - 1) * @limit
    extra_pagination_params
  end

  def extra_pagination_params
    # default it is a no-op
  end

  def pagination_per_page_limit
    10
  end

  def total_pages(total_count, limit)
    limit > 0 ? (total_count.to_f/limit).ceil : (total_count.to_f/pagination_per_page_limit).ceil
  end

  def paginate_array(array, page, limit)
    from = (page * limit) - limit
    if from >= array.length and page > 1
      # Return last page if user expects out of scope page
      page = total_pages(array.length, limit)
      from = (page * limit) - limit
    end
    to = from + limit - 1
    values = array.values_at(from..to)
    total = array.length
    to = (to + 1) > total ? total : to + 1
    pages_total = total_pages(total, limit)
    [values.compact, total, pages_total, page, from + 1, to]
  end

end
