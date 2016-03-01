class CreateInstagram
  include CallableClass

  attr_reader :attrs

  def initialize(attrs)
    @attrs = attrs
  end

  def call
    photo = Photo.find_or_initialize_by uid: attrs.id, source: Photo::INSTAGRAM

    unless photo.persisted?
      photo.src              = attrs.images.standard_resolution.url
      photo.thumb            = attrs.images.thumbnail.url
      photo.url              = attrs.link
      photo.user_uid         = attrs.user.id
      photo.username         = attrs.user.username
      photo.fullname         = RemoveEmojis.call(attrs.user.full_name)
      photo.userpic          = attrs.user.profile_picture
      photo.body             = RemoveEmojis.call(attrs.caption.try(:text))
      photo.state            = Photo::AWAITING_MODERATION
      photo.posted_at        = DateTime.strptime(attrs.created_time, '%s')
      photo.save
    end

    photo
  end
end
