class Url < ApplicationRecord
  validates_presence_of( :long_url, :short_url)

  def self.db_populator( n )

    raise ArgumentError, "Argument must be an integer less than or equal to 50" unless n.is_a?(Integer) && n <= 50

    begin
      n.times do
        long_url  = Faker::Internet.url("#{Faker::Internet.domain_name}", "/#{Faker::Internet.slug(nil, '/')}/#{Faker::Internet.slug(nil, '/')}", 'http')
        short_url = SecureRandom.hex(3)
        new_url = Url.create({long_url: long_url, short_url: short_url, hits: SecureRandom.random_number(200)})
        new_url.update({short_url: "#{new_url.id.to_s(36)}#{SecureRandom.hex(1)}"  } ) #Added update to make sure it is the shortest & unique hash every time.
      end
      puts "#{n} urls generated succesfully."
      return true
    rescue Exception => e
      Raise e
    end

  end

end


