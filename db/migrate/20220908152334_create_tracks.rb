class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.references :artist, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true
      t.string :artist_name
      t.string :album_name
      t.integer :likes_count

      t.timestamps
    end
  end
end
