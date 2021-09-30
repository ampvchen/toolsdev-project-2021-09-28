class ChangeNameToCity < ActiveRecord::Migration[5.2]
  def change
    rename_column :locations, :name, :city
  end
end
