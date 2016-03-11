class User < ActiveRecord::Base
  # validates_uniqueness_of :uid
  # validates_presence_of :email

  has_many :authentications

  MODERATORS = %w{
    gmaxsnz@gmail.com
  }

  def moderator?
    MODERATORS.include?(email)
  end
end