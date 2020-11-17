class AddForeignKeyToTrucks < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :trucks, :users
  end
end
