class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :provider
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at
      t.timestamps null: false
    end

    add_index :auth_tokens, [:user_id, :provider], unique: true
  end
end
