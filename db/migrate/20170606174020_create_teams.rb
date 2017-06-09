class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :short_name
      t.string :color
      t.timestamps
    end
  end
end
