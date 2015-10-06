class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :address
      t.integer :zip
      t.integer :rating_sum
      t.integer :rating_count

      t.timestamps null: false
    end
  end
end
