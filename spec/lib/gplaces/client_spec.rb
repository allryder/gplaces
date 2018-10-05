require "webmock/rspec"

RSpec.describe Gplaces::Client do
  let(:client) { Gplaces::Client.new("API") }

  describe "#autocomplete" do
    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&key=API")
        .to_return(fixture("autocomplete.json"))
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&key=INVALID")
        .to_return(fixture("error_request_denied.json"))
    end

    it "returns a list of predictions" do
      predictions = client.autocomplete("Vict")
      expect(predictions).to be_a(Array)
      expect(predictions.first).to be_a(Gplaces::Prediction)
    end

    describe "error handling" do
      it "throws an error when API KEY is invalid" do
        client = Gplaces::Client.new("INVALID")
        expect { client.autocomplete("Vict") }.to raise_error(Gplaces::RequestDeniedError)
      end

      it "verifies if input is valid before request" do
        client = Gplaces::Client.new("Valid")
        expect { client.autocomplete("") }.to raise_error(Gplaces::InvalidRequestError)
      end
    end
  end

  describe "#details" do
    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=API&language=en" \
                         "&placeid=ChIJl-emOTauEmsRVuhkf-gObv8")
        .to_return(fixture("details.json"))
    end

    it "gets the place details (city)" do
      expect(client.details("ChIJl-emOTauEmsRVuhkf-gObv8", "en").city).to eq("Pyrmont")
    end

    it "gets the place details (postal code)" do
      expect(client.details("ChIJl-emOTauEmsRVuhkf-gObv8", "en").postal_code).to eq("2009")
    end

    context "when options are added" do
      let(:place_id) { "ChIJl-emOTauEmsRVuhkf-gObv8" }
      let(:fields) { "address_component,formatted_address,geometry,type,vicinity,place_id" }
      let(:options) { { fields: fields } }
      subject { client.details(place_id, "en", options) }

      before do
        stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?fields=#{fields}" \
                           "&key=API&language=en&placeid=#{place_id}")
          .to_return(fixture("details.json"))
      end

      it "gets the place details (city)" do
        expect(subject.city).to eq("Pyrmont")
      end
    end

    context "when place details are not available" do
      before do
        stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=API&language=en" \
                           "&placeid=ChIJl-emOTauEmsRVuhkf-gObv8")
          .to_return(fixture("error_not_found.json"))
      end

      it "throws an error" do
        expect { client.details("ChIJl-emOTauEmsRVuhkf-gObv8", "en") }.to raise_error(Gplaces::NotFoundError)
      end
    end

    context "when results come empty" do
      before do
        stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=API&language=en" \
                         "&placeid=ChIJl-emOTauEmsRVuhkf-gObv8")
        .to_return(fixture("no_details.json"))
      end

      it "throws an error" do
        expect { client.details("ChIJl-emOTauEmsRVuhkf-gObv8", "en") }.to raise_error(Gplaces::NotFoundError)
      end
    end
  end
end
