class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name, null: false

      t.timestamps
    end

    add_index :teams, :team_name, unique: true
  end
end
