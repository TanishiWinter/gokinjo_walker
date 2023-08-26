class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower_id, null: false, foreign_key: true
      t.references :followed_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
