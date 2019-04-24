require 'rails_helper'

RSpec.describe Url, type: :model do
  # Trivial presence tests
  it { should validate_presence_of(:long_url) }
  it { should validate_presence_of(:short_url) }
end
