class AddNicknameToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :nickname, :string
  end
end
