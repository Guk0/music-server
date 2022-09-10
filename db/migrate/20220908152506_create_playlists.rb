class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.references :owner, polymorphic: true, null: false
      t.string :title
      t.integer :list_type, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
