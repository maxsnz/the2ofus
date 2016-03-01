class ImportInstagram
  include CallableClass

  attr_reader :options, :tag

  def initialize(options = {})
    @tag = options.delete(:tag)
    @mindate = options.delete(:mindate)
    @options = options.reverse_merge(count: 20)
  end

  def call
    begin
      # puts 'begin'
      response = Instagram.client.tag_recent_media URI.encode(tag), options
      puts 'end'
      response.each do |photo_attrs|
        valid_photo?(photo_attrs) && CreateInstagram.call(photo_attrs)
        puts (DateTime.strptime(photo_attrs.created_time, '%s') > @mindate.to_date)
      end
      # puts 'save'
      
      if (DateTime.strptime(response.last.created_time, '%s') > @mindate.to_date)
        pagination = response.pagination
        id = pagination.respond_to?(:next_max_id) && pagination.next_max_id
        id.presence && ImportInstagram.call(options.merge(max_id: id, tag: tag, mindate: @mindate))
        puts id
      end


      true
    rescue JSON::ParserError
      false
    end
  end

  private

  def valid_photo?(attrs)
    attrs.type == "image" && (DateTime.strptime(attrs.created_time, '%s') > @mindate.to_date)
  end
end
