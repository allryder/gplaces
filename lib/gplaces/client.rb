require "curl"
require "json"

module Gplaces
  class Client
    def initialize(api_key)
      @key = api_key
    end

    def autocomplete(input, options = {})
      fail InvalidRequestError if input.empty?

      params = {
        key:      @key,
        input:    input,
        types:    options[:types],
        language: options[:language],
        location: (options[:location].join(",") if options[:location]),
        radius:   options[:radius],
      }.delete_if { |_k, v| v.nil? }

      response = json_response(:autocomplete, params)
      check_status(response)
      predictions(response[:predictions])
    end

    def details(place_id, language)
      params = {
        key:      @key,
        placeid:  place_id,
        language: language,
      }.delete_if { |_k, v| v.nil? }

      response = json_response(:details, params)
      check_status(response)
      place(response[:result])
    end

    private

    def json_response(type, params)
      JSON.parse(Curl.get("https://maps.googleapis.com/maps/api/place/#{type}/json", params).body_str,
                 symbolize_names: true)
    end

    def predictions(list)
      list.map { |attributes| Prediction.new(attributes) }
    end

    def place(attributes)
      Place.new(attributes)
    end

    def check_status(response)
      fail RequestDeniedError if response[:status] == "REQUEST_DENIED"
      fail InvalidRequestError if response[:status] == "INVALID_REQUEST"
      fail NotFoundError if response[:status] == "NOT_FOUND"
    end
  end
end
