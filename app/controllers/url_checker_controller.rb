class UrlCheckerController < ApplicationController
  def top100
    top100 = Url.where('hits > ?', 0).order("hits DESC").limit(100).pluck(:short_url, :hits)
    render json: {'top_100': top100 }, status: 200
  end

  def create_short_url
    long_url  = params['url']
    short_url = generate_short_hash

    if long_url =~ URI::regexp
      new_url = Url.create({long_url: long_url, short_url: short_url})
      new_url.update({short_url: "#{new_url.id.to_s(36)}#{SecureRandom.hex(1)}"  } ) #Added update to make sure it is the shortest & unique hash every time.
    end

    if new_url.present?
      TitleCrawlerWorker.perform_async(new_url.id.to_s, new_url.long_url)
      render json: { short_url: new_url.short_url }, status: 201
    else
      render json: "Validation failed: Url must be a valid long url", status: 422
    end
  end

  def generate_short_hash
    SecureRandom.hex(3)
  end

  def redirect_to_short_url
    found_url = Url.find_by_short_url( params[:short_hash] )

    if found_url
      found_url.update({ hits: found_url.hits.to_i + 1 })
      render json: { long_url: found_url.long_url }, status: 200
    else
      render json: "Url not found", status: 404
    end
  end

end
