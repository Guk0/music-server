class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
