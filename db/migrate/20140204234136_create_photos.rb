class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :source, null: false
      t.string :uid, null: false

      t.string :state, null: false

      t.string :src
      t.text :body
      t.string :user_uid, null: false
      t.string :username
      t.string :fullname
      t.string :userpic
      t.string :url

      t.date :date

      t.integer :rating, null: false, default: 0

      t.timestamps
    end
    add_index :photos, [ :source, :uid ], unique: true
  end
end
