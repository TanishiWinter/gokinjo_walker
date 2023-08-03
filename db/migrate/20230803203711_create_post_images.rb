class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|

      t.string :title, null: false, default:""
      t.text :body
      t.string :address, null: false, default:""
      t.integer :user_id
      t.float  :latitude
      t.float  :longitude
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
