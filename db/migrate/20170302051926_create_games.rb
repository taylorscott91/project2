class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :group_id
    end
  end
  # Consider adding more attributes to your Game model here. Things such as a description,
  # release year, number of players, etc.
end
