module PaginationHelper

  MIN_NUMBER_OF_PAGES_ON_EITHER_SIDE = 1
  MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES = MIN_NUMBER_OF_PAGES_ON_EITHER_SIDE * 2

  def pagination_buttons(total, page, limit = 10)
    prev_page = page - 1
    next_page = page + 1
    last_page = (total.to_f/limit).ceil

    return if last_page <= 1

    content_tag(:ul, {class: 'pagination'}) do

      page == 1 ? pagination_link(content_tag(:button, '<', class: 'disabled', disabled: "disabled")) : pagination_link(content_tag(:button, '<', value: prev_page, type: 'submit', name: 'page'))

      # If pages are less than minimum pages on screen, we can show them all
      if last_page < minimum_pages_on_screen
        render_pagination_buttons(last_page, limit, page)
      else
        if page < minimum_no_of_pages
          render_pagination_buttons(minimum_no_of_pages, limit, page)
          middle_ellipsis
          concat(content_tag(:li, content_tag(:button, last_page, value: last_page, type: 'submit', name: 'page')))
        elsif middle_page?(last_page, page)
          display_middle_ellipsis(last_page, limit, page)
        else
          display_pagination_for_last_page(last_page, limit, page)
        end
      end
      display_pagination_links(last_page, next_page, page)
    end
  end

  def adjoining_buttons(counter, page, limit)
    if counter == page
      concat(content_tag(:li, content_tag(:button, counter, name: 'page'), :class => 'active'))
    else
      concat(content_tag(:li, content_tag(:button, counter, value: counter, type: 'submit', name: 'page')))
    end
  end

  def pagination_link(link)
    concat(content_tag(:li, link, class: 'navigator'))
  end

  def display_pagination_links(last_page, next_page, page)
    if page < last_page then
      pagination_link(content_tag(:button, '>', value: next_page, type: 'submit', name: 'page'))
    else
      pagination_link(content_tag(:button, '>', class: 'disabled', disabled: "disabled"))
    end
  end

  def display_pagination_for_last_page(last_page, limit, page)
    concat(content_tag(:li, content_tag(:button, 1, value: 1, type: 'submit', name: 'page')))
    middle_ellipsis
    ((last_page - (PaginationHelper::MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES))..last_page).each do |counter|
      adjoining_buttons(counter, page, limit)
    end
  end

  def middle_ellipsis
    concat(content_tag(:li, content_tag(:button, '...', disabled: "disabled")))
  end

  def middle_page?(last_page, page)
    (last_page - (PaginationHelper::MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES)) >= page && page > (PaginationHelper::MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES)
  end


  def display_middle_ellipsis(last_page, limit, page)
    concat(content_tag(:li, content_tag(:button, 1, value: 1, type: 'submit', name: 'page')))
    middle_ellipsis
    (beginning_of_middle_page(page)..end_of_middle_page(page)).each do |counter|
      adjoining_buttons(counter, page, limit)
    end
    middle_ellipsis
    concat(content_tag(:li, content_tag(:button, last_page, value: last_page, type: 'submit', name: 'page')))
  end

  def end_of_middle_page(page)
    (page + PaginationHelper::MIN_NUMBER_OF_PAGES_ON_EITHER_SIDE)
  end

  def beginning_of_middle_page(page)
    (page - PaginationHelper::MIN_NUMBER_OF_PAGES_ON_EITHER_SIDE)
  end

  def minimum_no_of_pages
    (1 + (PaginationHelper::MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES))
  end

  def render_pagination_buttons(last_page, limit, page)
    (1..last_page).each do |counter|
      adjoining_buttons(counter, page, limit)
    end
  end

  def minimum_pages_on_screen
    (4 + (PaginationHelper::MIN_NUMBER_OF_PAGES_ON_BOTH_SIDES))
  end


end
