class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :pid
      t.timestamps null: false
    end
  end
end
