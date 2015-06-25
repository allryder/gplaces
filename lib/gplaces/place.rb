module Gplaces
  class Location
    attr_reader :lat, :lng

    def initialize(attributes)
      @lat = attributes[:lat].to_f
      @lng = attributes[:lng].to_f
    end

    def to_a
      [lat, lng]
    end

    def to_s
      to_a.join(",")
    end
  end

  class Place
    attr_reader :formatted_address, :location

    def initialize(attributes)
      @formatted_address = attributes[:formatted_address]
      @location          = Location.new(attributes[:geometry][:location]) if attributes[:geometry]
    end
  end
end
