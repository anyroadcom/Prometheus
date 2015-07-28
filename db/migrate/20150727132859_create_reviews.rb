class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :guide, index: true, foreign_key: true
      t.float :score
      t.text :body
      t.string :image_url
      t.datetime :review_date

      t.timestamps null: false
    end
    add_index :reviews, :score
    add_index :reviews, :review_date
  end
end
