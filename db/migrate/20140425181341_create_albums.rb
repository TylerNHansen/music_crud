class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :kind
      t.string :name
      t.references :band, index: true

      t.timestamps
    end
    add_index :albums, :name
  end
end
