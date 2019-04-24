class UrlCheckerController < ApplicationController
  def top100
    render json: {'top_100': %w( one two three four fivee )}, status: 200
  end

  def create_short_url
    long_url  = params['url']
    short_url = generate_short_hash
    new_url = Url.create({long_url: long_url, short_url: short_url}) if long_url =~ URI::regexp

    if new_url.present?
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
      render json: { long_url: found_url.long_url }, status: 200
    else
      render json: "Url not found", status: 404
    end
  end

end
