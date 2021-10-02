class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.datetime :datetime
      t.integer :temp_c
      t.integer :temp_f
      t.integer :location_id
      t.text :weather_desc

      t.timestamps
    end
  end
end
