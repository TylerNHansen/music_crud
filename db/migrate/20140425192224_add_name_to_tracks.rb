class AddNameToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :title, :string, null: false
  end
end
