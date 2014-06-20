require 'json'

module Gplaces
  class Client

    def initialize(api_key)
      @key = api_key
    end

    def autocomplete(input, options = {})
      raise InvalidRequestError if input.empty?
      input = URI::encode(input)
      location = options[:location]
      radius = options[:radius]
      language = options[:language]
      #TODO: Use httparty params
      params = "input=#{input}"
      params << "&types=geocode&sensor=true&key=#{@key}"
      params << "&language=#{language}" if language
      params << "&location=#{location.first},#{location.last}" if location
      params << "&radius=#{radius}" if radius

      response = HTTParty.get("#{AUTOCOMPLETE_URI}json?#{params}")
      check_status(response)
      predictions(JSON.parse(response.body)['predictions'])
    end

    def details(reference, language)
      response = HTTParty.get("#{PLACE_DETAILS_URI}json?reference=#{reference}&sensor=true&key=#{@key}&language=#{language}")
      check_status(response)
      attrs = JSON.parse(response.body)['result']
      attrs[:city] = city(attrs)
      attrs[:is_city] = is_city(attrs['address_components'])
      place(attrs)
    end

    def is_city(address_components)
      !address_components.nil? && !address_components.empty? && address_components[0]["types"].include?('locality')
    end

    private
    def predictions(preds)
      preds.map{|pred| Prediction.new(pred)}
    end

    def place(attrs)
      Place.new(attrs)
    end

    def check_status(response)
      raise RequestDeniedError if response['status'] == 'REQUEST_DENIED'
      raise InvalidRequestError if response['status'] == 'INVALID_REQUEST'
    end

    def city(json)
      address_components = json['address_components']
      if address_components && !address_components.empty?
        address_components.each do |c|
          types = c['types']
          if types && types.include?('locality')
            return c['short_name']
          end
        end
      end
      nil
    end
  end
end