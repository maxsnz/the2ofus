class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :access_token

      t.timestamps null: false
    end
    add_index :authentications, :user_id
    add_index :authentications, [:uid, :provider], unique: true
  end
end
