module Gplaces
  class Prediction
    include Virtus.model
    attribute :description, String
    attribute :reference , String
    attribute :id, String
    attribute :terms, Array
    attribute :matched_substrings, Array
  end
end