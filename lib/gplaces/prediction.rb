module Gplaces
  class Prediction
    include Virtus.model
    attribute :description,        String
    attribute :place_id,           String
    attribute :reference,          String # deprecated, replaced by place_id
    attribute :id,                 String # deprecated, replaced by place_id
    attribute :terms,              Array
    attribute :matched_substrings, Array
  end
end
