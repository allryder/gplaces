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
    attr_reader :name, :location, :city, :postal_code

    def initialize(attributes)
      @name        = attributes[:name]
      @location    = location_from(attributes[:geometry])
      @city        = extract(:locality, attributes[:address_components])
      @postal_code = extract(:postal_code, attributes[:address_components])
    end

    private

    def location_from(geometry)
      return if geometry.nil?

      Location.new(geometry[:location])
    end

    def extract(key, components)
      return if components.nil? || components.empty?

      components.each do |component|
        types = component[:types]
        return component[:long_name] if types && types.include?(key.to_s)
      end
      nil
    end
  end
end
