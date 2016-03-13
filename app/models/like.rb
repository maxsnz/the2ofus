class Like < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user

  validates_presence_of :user_id, :photo_id

end
