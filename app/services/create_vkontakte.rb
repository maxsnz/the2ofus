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
      photo.src              = post["attachments"].find{|a| a["type"] == "photo"}["photo"]["photo_604"]
      photo.url              = "http://vk.com/#{user["screen_name"]}?w=wall#{uid}"
      photo.user_uid         = user["id"]
      photo.username         = user["screen_name"]
      photo.fullname         = RemoveEmojis.call("#{user["first_name"]} #{user["last_name"]}")
      photo.userpic          = user["photo_50"]
      photo.body             = RemoveEmojis.call(post["text"])
      photo.save
    end

    photo
  end
end
