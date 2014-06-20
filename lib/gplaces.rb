require 'httparty'
require 'virtus'

module Gplaces

  BASE_URI = 'https://maps.googleapis.com/maps/api/place/'
  AUTOCOMPLETE_URI = BASE_URI + 'autocomplete/'
  PLACE_DETAILS_URI = BASE_URI + 'details/'

  autoload :VERSION, 'gplaces/version'
  autoload :Client, 'gplaces/client'
  autoload :Prediction, 'gplaces/prediction'
  autoload :Place, 'gplaces/place'
  autoload :Error, 'gplaces/error'
end