require 'json'

module Gplaces
  class Client

    def initialize(api_key)
      @key = api_key
    end

    def autocomplete(input, options = {})
      raise InvalidRequestError if input.empty?

      input    = URI::encode(input)
      location = options[:location]
      radius   = options[:radius]
      types    = options[:types]
      language = options[:language]

      params = "input=#{input}"
      params << "&key=#{@key}"
      params << "&types=#{types}" if types
      params << "&language=#{language}" if language
      params << "&location=#{location.first},#{location.last}" if location
      params << "&radius=#{radius}" if radius

      response = HTTParty.get("#{AUTOCOMPLETE_URI}json?#{params}")
      check_status(response)
      predictions(JSON.parse(response.body)['predictions'])
    end

    def details(place_id, language)
      params = "placeid=#{place_id}"
      params << "&key=#{@key}"
      params << "&language=#{language}" if language

      response = HTTParty.get("#{PLACE_DETAILS_URI}json?#{params}")
      check_status(response)
      place(JSON.parse(response.body)['result'])
    end

    private

    def predictions(list)
      list.map { |attrs| Prediction.new(attrs) }
    end

    def place(attrs)
      Place.new(attrs)
    end

    def check_status(response)
      raise RequestDeniedError if response['status'] == 'REQUEST_DENIED'
      raise InvalidRequestError if response['status'] == 'INVALID_REQUEST'
    end
  end
end
