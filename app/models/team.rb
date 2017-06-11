class Team < ApplicationRecord

  has_many :players

  searchable do
    text    :club_name, as: :club_name_acs
    integer :id

    join(:name, :target => Player, :type => :text, :join => {:from => :team_id, :to => :id},as: :name_acs)
  end
end
