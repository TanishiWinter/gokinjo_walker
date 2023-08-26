class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment
      # t.references :user, null: false, foreign_key: true
      # t.references :post_image, null: false, foreign_key: true
      t.integer :user_id
      t.integer :post_image_id

      t.timestamps
    end
  end
end
