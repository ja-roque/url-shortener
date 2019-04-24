FactoryBot.define do
  factory :url do
    long_url { Faker::Internet.url("#{Faker::Internet.domain_name}", "/#{Faker::Internet.slug(nil, '/')}", 'http') }
    short_url { SecureRandom.hex(3)}
  end
end