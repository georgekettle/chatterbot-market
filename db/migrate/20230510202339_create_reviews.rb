class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 1
      t.text :comment
      t.references :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
