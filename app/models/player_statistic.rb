class PlayerStatistic < ApplicationRecord

  belongs_to :player

  searchable do

   integer :minutes_played
   integer :points
   integer :goals


  end

end
