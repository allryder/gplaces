module Gplaces
  BASE_URI          = "https://maps.googleapis.com".freeze
  AUTOCOMPLETE_URI  = "/maps/api/place/autocomplete/json".freeze
  PLACE_DETAILS_URI = "/maps/api/place/details/json".freeze

  autoload :VERSION,             "gplaces/version"
  autoload :Client,              "gplaces/client"
  autoload :Prediction,          "gplaces/prediction"
  autoload :Place,               "gplaces/place"
  autoload :Error,               "gplaces/error"
  autoload :RequestDeniedError,  "gplaces/error"
  autoload :InvalidRequestError, "gplaces/error"
end
