class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :team_id, null: false
      t.string :user_name, null: false
      t.string :user_email, null: false
      t.string :user_auth_token, null: false
      t.integer :user_status, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :user_name, unique: true
    add_index :users, :user_email, unique: true
    add_index :users, :user_auth_token, unique: true
  end
end
