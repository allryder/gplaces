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
    attr_reader :name, :location, :city

    def initialize(attributes)
      @name     = attributes[:name]
      @location = location_from(attributes[:geometry])
      @city     = city_from_address_components(attributes[:address_components])
    end

    private

    def location_from(geometry)
      return if geometry.nil?

      Location.new(geometry[:location])
    end

    def city_from_address_components(components)
      return if components.nil? || components.empty?

      components.each do |component|
        types = component[:types]
        return component[:short_name] if types && types.include?("locality")
      end
      nil
    end
  end
end
