module Gplaces
  class Prediction
    attr_reader :place_id, :description

    def initialize(attributes)
      @place_id    = attributes[:place_id].to_s
      @description = attributes[:description].to_s
    end
  end
end
