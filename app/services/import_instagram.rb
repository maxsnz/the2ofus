class ImportInstagram
  include CallableClass

  attr_reader :options, :tag

  def initialize(options = {})
    @tag = options.delete(:tag)
    @options = options.reverse_merge(count: 100)
  end

  def call
    begin

      response = Instagram.client.tag_recent_media URI.encode(tag), options
      # p response  
      # puts response

      response.each do |photo_attrs|
        valid_photo?(photo_attrs) && CreateInstagram.call(photo_attrs)
      end

      pagination = response.pagination
      id = pagination.respond_to?(:next_max_id) && pagination.next_max_id
      id.presence && ImportInstagram.call(options.merge(max_id: id, tag: tag))

      true
    rescue JSON::ParserError
      false
    end
  end

  private

  def valid_photo?(attrs)
    attrs.type == "image"
  end
end
