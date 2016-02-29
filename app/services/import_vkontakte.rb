class ImportVkontakte
  include CallableClass

  attr_reader :options, :tag

  def initialize(options = {})
    @tag = options.delete(:tag)
    @options = options
  end

  def call
    begin
      resp = VkApi.get "/newsfeed.search", query: {q: "##{tag}", start_time: 1.week.ago.to_i, extended: 1, fields: "photo_50", count: 200}.merge(options)

      return if resp['error'].present?

      data = resp["response"]

      data["items"].each do |attrs|
        valid?(attrs) && CreateVkontakte.call(attrs, data["profiles"].find {|p| p["id"] == attrs["owner_id"]})
      end

      next_from = data["next_from"]
      next_from.presence && ImportVkontakte.call(options.merge(start_from: next_from, tag: tag))

      true
    rescue JSON::ParserError
      false
    end
  end

  private

  def valid?(attrs)
    attrs["post_type"] == "post" && attrs["owner_id"] > 0 && Array.wrap(attrs["attachments"]).any? { |a| a["type"] == "photo" }
  end
end
