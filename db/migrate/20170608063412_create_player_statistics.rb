class CreatePlayerStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :player_statistics do |t|
      t.references :player, index: true
      t.integer :goals
      t.integer :assists
      t.integer :minutes_played
      t.integer :saves
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :points
    end
    add_foreign_key :player_statistics, :players
  end
end
