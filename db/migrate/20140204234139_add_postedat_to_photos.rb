class AddPostedatToPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :date
    add_column :photos, :posted_at, :datetime
  end
end
