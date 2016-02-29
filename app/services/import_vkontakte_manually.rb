class ImportVkontakteManually
  include CallableClass

  attr_reader :options, :url

  def initialize(options = {})
    @url = options.delete(:url)
    @options = options
  end

  def call
    return if !owner_id || !id

    return true if Photo.vk.where(uid: "#{owner_id}_#{id}").exists?

    begin
      resp = VkApi.get "/wall.get", query: {count: 100, owner_id: owner_id, extended: 1, filter: 'owner'}.merge(options)

      return if resp['error'].present?

      data = resp["response"]

      data["items"].each do |attrs|
        if valid?(attrs)
          CreateVkontakte.call(attrs, data["profiles"].find {|p| p["id"] == attrs["owner_id"]})

          return true
        end
      end

      false
    rescue JSON::ParserError
      false
    end
  end

  private

  def owner_id
    # https://vk.com/id277716070?w=wall277716070_45%2Fall
    url[/wall(\d+)_/, 1]
  end

  def id
    url[/wall\d+_(\d+)/, 1]
  end

  def valid?(attrs)
    attrs['id'] == id.to_i && attrs["post_type"] == "post" && attrs["owner_id"] > 0 && Array.wrap(attrs["attachments"]).any? { |a| a["type"] == "photo" }
  end
end
