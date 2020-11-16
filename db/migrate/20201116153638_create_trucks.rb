class CreateTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :trucks do |t|
      t.title :title
      t.string :location
      t.integer :price_per_day
      t.string :size
      t.title :description

      t.timestamps
    end
  end
end
