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

      response = JSON.parse(connection.get(AUTOCOMPLETE_URI, params).body)
      check_status(response)
      predictions(response["predictions"])
    end

    def details(place_id, language)
      params = {
        key:      @key,
        placeid:  place_id,
        language: language,
      }.delete_if { |_k, v| v.nil? }

      response = JSON.parse(connection.get(PLACE_DETAILS_URI, params).body)
      check_status(response)
      place(response["result"])
    end

    private

    def connection
      @connection ||= Faraday.new(url: BASE_URI)
    end

    def predictions(list)
      list.map { |attrs| Prediction.new(attrs) }
    end

    def place(attrs)
      Place.new(attrs)
    end

    def check_status(response)
      fail RequestDeniedError if response["status"] == "REQUEST_DENIED"
      fail InvalidRequestError if response["status"] == "INVALID_REQUEST"
    end
  end
end
