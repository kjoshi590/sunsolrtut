class Player < ApplicationRecord




  searchable do
    text    :name, as: :name_acs
    time    :created_at, stored: true
    time    :updated_at, stored: true

    string :position

  end


  def name
    first_name + ' ' +  last_name
  end
end
