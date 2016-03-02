class CreateVkontakte
  include CallableClass

  attr_reader :post, :user

  def initialize(post, user)
    @post = post
    @user = user
  end

  def call
    uid = "#{user["id"]}_#{post["id"]}"

    photo = Photo.find_or_initialize_by uid: uid, source: Photo::VKONTAKTE

    unless photo.persisted?
      if (post["attachments"].find{|a| a["type"] == "photo"}["photo"]["photo_807"])
        photo.src            = post["attachments"].find{|a| a["type"] == "photo"}["photo"]["photo_807"]
      else
        photo.src            = post["attachments"].find{|a| a["type"] == "photo"}["photo"]["photo_604"]
      end
      photo.thumb            = post["attachments"].find{|a| a["type"] == "photo"}["photo"]["photo_130"]
      photo.url              = "http://vk.com/wall#{post["owner_id"]}_#{post["id"]}"
      photo.user_uid         = user["id"]
      if post["owner_id"] > 0   
        photo.fullname       = RemoveEmojis.call("#{user["first_name"]} #{user["last_name"]}")
      else
        photo.fullname       = user["name"]
      end
      photo.username         = user["screen_name"]
      photo.userpic          = user["photo_100"]
      photo.body             = RemoveEmojis.call(post["text"])
      photo.state            = Photo::AWAITING_MODERATION
      photo.posted_at        = DateTime.strptime(post['date'].to_s, '%s') 
      photo.save
    end

    photo
  end
end
