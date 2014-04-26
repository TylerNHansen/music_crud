class AddActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: false
    add_column :users, :activate_token, :string
  end
end
