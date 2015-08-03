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

      json = json_response(:autocomplete, params)
      check_status(json)
      create_predictions_from(json[:predictions])
    end

    def details(place_id, language)
      params = {
        key:      @key,
        placeid:  place_id,
        language: language,
      }.delete_if { |_k, v| v.nil? }

      json = json_response(:details, params)
      check_status(json)
      create_place_from(json[:result])
    end

    def details_multi(*place_ids, language)
      requests = place_ids.map { |place_id|
        params = {
          key:      @key,
          placeid:  place_id,
          language: language,
        }.delete_if { |_k, v| v.nil? }
         .map { |k, v| "#{k}=#{v}" }
        "https://maps.googleapis.com/maps/api/place/details/json?#{params.join('&')}"
      }

      [].tap do |places|
        Curl::Multi.get(requests, {}, pipeline: true) do |response|
          json = JSON.parse(response.body, symbolize_names: true)
          if json[:status] == "OK"
            places << create_place_from(json[:result])
          else
            places << nil
          end
        end
      end
    end

    private

    def json_response(type, params)
      JSON.parse(Curl.get("https://maps.googleapis.com/maps/api/place/#{type}/json", params).body,
                 symbolize_names: true)
    end

    def create_predictions_from(list)
      list.map { |attributes| Prediction.new(attributes) }
    end

    def create_place_from(attributes)
      Place.new(attributes)
    end

    def check_status(response)
      fail RequestDeniedError if response[:status] == "REQUEST_DENIED"
      fail InvalidRequestError if response[:status] == "INVALID_REQUEST"
      fail NotFoundError if response[:status] == "NOT_FOUND"
    end
  end
end
