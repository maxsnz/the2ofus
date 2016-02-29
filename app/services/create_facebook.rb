class CreateFacebook
  include CallableClass

  attr_reader :post

  def initialize(post)
    @post = post
  end

  def call
    photo = Photo.find_or_initialize_by uid: post["post_id"], source: Photo::FACEBOOK

    likes = post["post_likes"].to_i

    unless photo.persisted?
      photo.src              = post["post_img"]
      photo.remote_image_url = photo.src
      photo.url              = post["post_url"]
      photo.user_uid         = post["user_id"]

      username = post['user_url'].sub(%r{^.*/}, '').sub(%r{\?.*$}, '')

      photo.username = username
      photo.userpic  = "https://graph.facebook.com/#{username}/picture"
      photo.fullname = RemoveEmojis.call(post['user_name'])
      photo.body     = RemoveEmojis.call(post["post_content"])
      photo.fb_likes = likes
      photo.save
    end

    # photo.update_columns(fb_likes: likes) if photo.fb_likes != likes

    photo
  end
end
