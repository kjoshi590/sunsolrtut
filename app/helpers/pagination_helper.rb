module PaginationHelper

  MIN_PAGES_ON_EACH_SIDE = 1
  MIN_PAGES_ON_BOTH_SIDES = MIN_PAGES_ON_EACH_SIDE * 2

  def adjacent_links(counter, page, limit)
    if counter == page
      concat(content_tag(:li, content_tag(:button, counter, name: 'page'), :class => 'active'))
    else
      concat(content_tag(:li, content_tag(:button, counter, value: counter, type: 'submit', name: 'page')))
    end
  end

  def page_number_ellipsis
    concat(content_tag(:li, content_tag(:button, '...', disabled: "disabled")))
  end

  def navigation_link(link)
    concat(content_tag(:li, link, class: 'navigator'))
  end

  def paginate(total, page, limit = 10)
    prev_page = page - 1
    next_page = page + 1
    last_page = (total.to_f/limit).ceil

    return if last_page <= 1

    content_tag(:ul, {class: 'pagination'}) do

      first_page?(page) ? navigation_link(content_tag(:button, '<', class: 'disabled', disabled: "disabled")) : navigation_link(content_tag(:button, '<', value: prev_page, type: 'submit', name: 'page'))

      # If pages are less, show 'em all!
      if last_page < minimum_pages_on_screen
        render_paginated_links(last_page, limit, page)
      else
        if page < minimum_no_of_pages_in_pagination
          render_paginated_links(minimum_no_of_pages_in_pagination, limit, page)
          page_number_ellipsis
          concat(content_tag(:li, content_tag(:button, last_page, value: last_page, type: 'submit', name: 'page')))
        elsif middle_page?(last_page, page)
          display_pagination_for_middle_page(last_page, limit, page)
        else
          display_pagination_for_ending_page(last_page, limit, page)
        end
      end

      display_navigation_links(last_page, next_page, page)
    end
  end

  def middle_page?(last_page, page)
    (last_page - (PaginationHelper::MIN_PAGES_ON_BOTH_SIDES)) >= page && page > (PaginationHelper::MIN_PAGES_ON_BOTH_SIDES)
  end

  def display_navigation_links(last_page, next_page, page)
    if page < last_page then
      navigation_link(content_tag(:button, '>', value: next_page, type: 'submit', name: 'page'))
    else
      navigation_link(content_tag(:button, '>', class: 'disabled', disabled: "disabled"))
    end
  end

  def display_pagination_for_ending_page(last_page, limit, page)
    concat(content_tag(:li, content_tag(:button, 1, value: 1, type: 'submit', name: 'page')))
    page_number_ellipsis
    ((last_page - (PaginationHelper::MIN_PAGES_ON_BOTH_SIDES))..last_page).each do |counter|
      adjacent_links(counter, page, limit)
    end
  end

  def display_pagination_for_middle_page(last_page, limit, page)
    concat(content_tag(:li, content_tag(:button, 1, value: 1, type: 'submit', name: 'page')))
    page_number_ellipsis
    (beginning_of_middle_page(page)..end_of_middle_page(page)).each do |counter|
      adjacent_links(counter, page, limit)
    end
    page_number_ellipsis
    concat(content_tag(:li, content_tag(:button, last_page, value: last_page, type: 'submit', name: 'page')))
  end

  def end_of_middle_page(page)
    (page + PaginationHelper::MIN_PAGES_ON_EACH_SIDE)
  end

  def beginning_of_middle_page(page)
    (page - PaginationHelper::MIN_PAGES_ON_EACH_SIDE)
  end

  def minimum_no_of_pages_in_pagination
    (1 + (PaginationHelper::MIN_PAGES_ON_BOTH_SIDES))
  end

  def render_paginated_links(last_page, limit, page)
    (1..last_page).each do |counter|
      adjacent_links(counter, page, limit)
    end
  end

  def minimum_pages_on_screen
    (4 + (PaginationHelper::MIN_PAGES_ON_BOTH_SIDES))
  end

  def first_page?(page)
    page == 1
  end
end
