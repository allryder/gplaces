require 'spec_helper'

describe Gplaces::Error do

  it "forward error for now" do
    begin
      raise Gplaces::Error.new("Error!")
    rescue Gplaces::Error => error
      expect(error.message).to eq "Error!"
    end
  end
end
