require 'rails_helper'

RSpec.describe Url, type: :model do
  # Trivial presence tests
  it { should validate_presence_of(:long_url) }
  it { should validate_presence_of(:short_url) }

  describe ".db_populator" do
    subject { described_class.db_populator }
    # it { is_expected.to be_an_instance_of(described_class) }
    it 'should accept only integers <= 50 as parameters' do
      expect { Url.db_populator("a string") }.to raise_error(ArgumentError)
      expect { Url.db_populator(1.5) }.to raise_error(ArgumentError)
      expect { Url.db_populator(false) }.to raise_error(ArgumentError)
      expect { Url.db_populator(51) }.to raise_error(ArgumentError)
    end

    it 'should return true if successful' do
      expect(Url.db_populator(10)).to be_truthy
      expect(Url.db_populator(50)).to be_truthy
    end
  end
end

