class ImportVkontakte
  include CallableClass

  attr_reader :options, :tag

  def initialize(options = {})
    @tag = options.delete(:tag)
    @mindate = options.delete(:mindate)
    @options = options
  end

  def call
    begin
      resp = VkApi.get "/newsfeed.search", query: {q: "##{tag}", start_time: 1.week.ago.to_i, extended: 1, fields: "photo_50", count: 200}.merge(options)

      return if resp['error'].present?

      data = resp["response"]
      puts data

      data["items"].each do |attrs|
        valid?(attrs) && CreateVkontakte.call(attrs, data["profiles"].find {|p| p["id"] == attrs["owner_id"]})
      end

      # if (DateTime.strptime(response.last.date, '%s') > @mindate.to_date)
      #   next_from = data["next_from"]
      #   next_from.presence && ImportVkontakte.call(options.merge(start_from: next_from, tag: tag))
      # end

      true
    rescue JSON::ParserError
      false
    end
  end

  private

  def valid?(attrs)
    (DateTime.strptime(attrs.date, '%s') > @mindate.to_date) && attrs["post_type"] == "post" && attrs["owner_id"] > 0 && Array.wrap(attrs["attachments"]).any? { |a| a["type"] == "photo" }
  end
end
