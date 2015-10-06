class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.integer :building_id
      t.text :comment

      t.timestamps null: false
    end
  end
end
