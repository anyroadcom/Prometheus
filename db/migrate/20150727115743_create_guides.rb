class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.integer :anyguide_id
      t.string :trip_url

      t.timestamps null: false
    end
    add_index :guides, :anyguide_id
  end
end
