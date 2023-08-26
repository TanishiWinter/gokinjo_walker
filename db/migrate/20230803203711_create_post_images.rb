class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|

      t.string :title, null: false, default:""
      t.text :body
      t.string :address, null: false, default:""
      # t.references :user, null: false, foreign_key: true
      t.integer :user_id
      t.decimal :latitude, :precision => 9, :scale => 6, null: false
      t.decimal :longitude, :precision => 9, :scale => 6, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
