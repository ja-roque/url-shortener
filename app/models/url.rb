class Url < ApplicationRecord
  validates_presence_of( :long_url, :short_url)
end
