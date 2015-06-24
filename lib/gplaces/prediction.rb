module Gplaces
  class Prediction
    include Virtus.model
    attribute :place_id,    String
    attribute :description, String
  end
end
