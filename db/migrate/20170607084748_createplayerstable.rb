class Createplayerstable < ActiveRecord::Migration[5.0]
  def change

    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.references :team, index: true
      t.string :position
    end
    add_foreign_key :players, :teams
  end
end
