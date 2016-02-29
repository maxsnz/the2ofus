class ManualImport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :urls

  validates_presence_of :urls

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def import
    normalized_urls.each do |url|
      results[url] = result_for_url(url)
    end
  end

  def persisted?
    false
  end

  def results
    @results ||= {}
  end

  private

  def normalized_urls
    urls.to_s.lines.map(&:strip).reject(&:blank?)
  end

  def result_for_url(url)
    if valid_url?(url)
      import_class(url).call(url: url)
    else
      false
    end
  end

  def import_class(url)
    if url.include?('vk.com')
      ImportVkontakteManually
    # else
    #   ImportTwitterManually
    end
  end

  def valid_url?(url)
    url =~ %r{vk\.com/id\d+\?w=wall\d+_\d+} ||
      url =~ %r{twitter\.com/.*?/status/\d+}
  end
end
