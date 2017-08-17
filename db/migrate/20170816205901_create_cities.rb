class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
    	t.string :name

      t.timestamps null: false
    end

    create_table :cities_cleaners, id: false do |t|
      t.belongs_to :city, index: true, foreign_key: true
      t.belongs_to :cleaner, index: true, foreign_key: true
    end
  end
end
