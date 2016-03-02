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
      resp = VkApi.get "/newsfeed.search", query: {q: "##{tag} has:photo", extended: 1,  fields: "screen_name, photo_604, photo_100", count: 200}.merge(options) # , start_time: 1.day.ago.to_i,

      return if resp['error'].present?

      data = resp["response"]


      data["items"].each do |attrs|
        puts attrs['id']
        if valid?(attrs) 
          if attrs["owner_id"] > 0
            CreateVkontakte.call(attrs, data["profiles"].find {|p| p["id"] == attrs["owner_id"]})
          else
            CreateVkontakte.call(attrs, data["groups"].find {|p| p["id"] == attrs["owner_id"].abs})
          end
        end
      end

      if (DateTime.strptime(data["items"].last['date'].to_s, '%s') > @mindate.to_date)
        next_from = data["next_from"]
        next_from.presence && ImportVkontakte.call(options.merge(start_from: next_from, tag: tag))
      end

      true
    rescue JSON::ParserError
      false
    end
  end

  private

  def valid?(attrs)
    # выключена проверка на группу (attrs["owner_id"] > 0) - если меньше нуля, то группа
    # (DateTime.strptime(attrs['date'].to_s, '%s') > @mindate.to_date) && attrs["post_type"] == "post" && attrs["owner_id"] > 0 && Array.wrap(attrs["attachments"]).any? { |a| a["type"] == "photo" }
    (DateTime.strptime(attrs['date'].to_s, '%s') > @mindate.to_date) && attrs["post_type"] == "post" && Array.wrap(attrs["attachments"]).any? { |a| a["type"] == "photo" }
  end
end
