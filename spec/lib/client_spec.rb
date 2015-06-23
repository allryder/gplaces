require 'spec_helper'

describe Gplaces::Client do
  let(:client){ Gplaces::Client.new('API') }

  describe '#autocomplete' do
    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&key=API")
        .to_return(fixture('autocomplete.json'))
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&key=INVALID")
        .to_return(fixture('error_request_denied.json'))
    end

    it "returns a list of predictions" do
      predictions = client.autocomplete('Vict')
      expect(predictions).to be_a(Array)
      expect(predictions.first).to be_a(Gplaces::Prediction)
    end

    describe 'error handling' do
      it "throws an error when API KEY is invalid" do
        client = Gplaces::Client.new('INVALID')
        expect { client.autocomplete('Vict') }.to raise_error(Gplaces::RequestDeniedError)
      end

      it "verifies if input is valid before request" do
        client = Gplaces::Client.new('Valid')
        expect { client.autocomplete('') }.to raise_error(Gplaces::InvalidRequestError)
      end
    end
  end

  describe '#details' do
    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?key=API&language=en&placeid=ChIJl-emOTauEmsRVuhkf-gObv8")
        .to_return(fixture('details.json'))
    end

    it 'gets the place details' do
      expect(client.details('ChIJl-emOTauEmsRVuhkf-gObv8', 'en').formatted_address).to eq('Pirrama Rd, Pyrmont NSW 2009, Australia')
    end
  end
end
