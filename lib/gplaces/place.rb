module Gplaces
  class Location
    include Virtus.model
    attribute :lat, Float
    attribute :lng, Float

    def to_a
      [lat, lng]
    end

    def to_s
      to_a.join(",")
    end
  end

  class Geometry
    include Virtus.model
    attribute :location, Location
  end

  class Place
    include Virtus.model
    attribute :formatted_address, :String
    attribute :geometry, Geometry

    def location
      return if geometry.nil?
      geometry.location
    end
  end
end
