class ImportPhotos
  def self.call(tag: "the2ofus", mindate: "2016-01-01") # минимальная дата

    # ImportInstagram.call tag: tag, mindate: mindate
    ImportVkontakte.call tag: tag, mindate: mindate
  end
end
