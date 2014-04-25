class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.text :lyrics
      t.string :kind
      t.references :album, index: true

      t.timestamps
    end
  end
end
