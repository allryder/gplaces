module Gplaces
  class Location
    include Virtus.model
    attribute :lat, Float
    attribute :lng, Float

  end

  class Geometry
    include Virtus.model
    attribute :location, Location
  end

  class Place
    include Virtus.model
    attribute :formatted_address, :String
    attribute :city, :String
    attribute :geometry, Geometry
    attribute :is_city, :Boolean
  end

end