class RemoveEmojis
  def self.call(text)
    text.to_s.gsub(EmojiData.const_get(:FBS_REGEXP), '').gsub(/\u{1F3FE}|\u{1F3FB}|\u{1F3FC}|\u{1F3FD}|\u{1F3FF}/, '').strip
  end
end
