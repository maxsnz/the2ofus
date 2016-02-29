class PhotoUrl
  def self.call(photo, host: "specials.the-village.ru")
    "http://#{host}/photos/#{photo.id}"
  end
end
