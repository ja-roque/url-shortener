require 'rails_helper'

RSpec.describe 'Url shortener API', type: :request do
  # initialize test data
  let!(:url) { create_list(:url, 10) }
  let(:url_id) { url.first.short_url }

  # Test suite for GET /short_hash
  describe 'GET /:short_hash' do
    # make HTTP get request before each example
    before { get "/#{url_id}" }

    it 'returns long_url' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json['long_url']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    context 'when the short has doesn\'t exist' do
      before { get "/#{SecureRandom.hex( 3 )}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found failure message' do
        expect(response.body)
            .to match(/Url not found/)
      end
    end
  end

  # Test suite for GET /top.json
  describe 'GET /top.json' do
    before { get "/top.json/" }

    context 'When the records exist' do
      it 'returns the urls' do
        expect(json).not_to be_empty
        expect(json['top_100']).to be_instance_of(Array)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

  # Test suite for POST /url.json
  describe 'POST /url.json' do
    # valid payload
    let(:valid_attributes) { { url: 'https://www.google.com/search?q=bluecoding' } }

    context 'when the request is valid' do
      before { post '/url.json', params: valid_attributes }

      it 'creates a short_url' do
        expect(json['short_url']).not_to be_empty
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/url.json', params: { url: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Url must be a valid long url/)
      end
    end
  end

end