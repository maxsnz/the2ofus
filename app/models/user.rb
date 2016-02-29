class User < ActiveRecord::Base
  validates_uniqueness_of :uid
  validates_presence_of :email

  MODERATORS = %w{
    gmaxsnz@gmail.com
  }

  def moderator?
    MODERATORS.include?(email)
  end
end