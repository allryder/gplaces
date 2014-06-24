module Gplaces
  class Prediction
    include Virtus.model
    attribute :description,        String
    attribute :place_id,           String
    attribute :reference ,         String # deprecated as of June 24, 2014, replaced by place_id
    attribute :id,                 String # deprecated as of June 24, 2014, replaced by place_id
    attribute :terms,              Array
    attribute :matched_substrings, Array
  end
end
