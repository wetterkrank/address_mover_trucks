class CreateTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :trucks do |t|
      t.string :title
      t.string :location
      t.integer :price_per_day
      t.string :size
      t.text :description
      t.references :users, null: false, foreign_key: true
      #Ex:- :null => false
      t.timestamps
    end
  end
end
