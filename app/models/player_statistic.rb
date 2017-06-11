class PlayerStatistic < ApplicationRecord

  belongs_to :player

  searchable do

   integer :minutes_played
   integer :points


  end

end
