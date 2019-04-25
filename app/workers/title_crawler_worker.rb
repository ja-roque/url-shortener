class TitleCrawlerWorker
  include Sidekiq::Worker

  def perform(url_id, long_url)
    page_title = Nokogiri::HTML::Document.parse(HTTParty.get("#{long_url}").body).title
    url = Url.find url_id.to_i
    url.update({title: page_title}) if page_title
  end

end
