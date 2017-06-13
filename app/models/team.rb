class Team < ApplicationRecord

  has_many :players
  has_many :player_statistics, :through => :players

  searchable do
    text    :club_name, as: :club_name_acs
    integer :id

    string :club_name
    string :city
    string :stadium

    integer :goals_scored
    integer :cards
    integer :points

    join(:name, :target => Player, :type => :text, :join => {:from => :team_id, :to => :id},as: :name_acs)
  end

  def goals_scored
     goals = 0
     self.player_statistics.map {|s| goals += s.goals}
     return goals
  end

  def cards
    cards= 0
    self.player_statistics.map {|s| cards += (s.yellow_cards + (s.red_cards*2))}
    return cards
  end



end
