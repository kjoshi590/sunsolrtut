class Player < ApplicationRecord


  has_one :player_statistic
  belongs_to :team


  searchable do
    text    :name, as: :name_acs
    string  :position
    string  :name
    integer :minutes_played
    integer :points
    integer :team_id
    string  :club_name
    integer :goals_scored

    join(:club_name, :target => Team, :type => :text, :join => {:from => :id, :to => :team_id},as: :club_name_acs)
    join(:club_name, :target => Team, :type => :string, :join => {:from => :id, :to => :team_id})
  end


  def name
    first_name + ' ' +  last_name
  end

  def minutes_played
    self.player_statistic.minutes_played
  end

  def club_name
    self.team.club_name
  end

  def points
    self.player_statistic.points
  end

  def goals_scored
    self.player_statistic.goals
  end
end
