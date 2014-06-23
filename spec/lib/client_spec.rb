require 'spec_helper'

describe Gplaces::Client do

  before do
    stub_request(:get, Gplaces::AUTOCOMPLETE_URI + "json?input=Vict&key=API&sensor=true")
      .to_return(body: fixture('autocomplete.json'), headers: {:content_type => "application/json; charset=utf-8"})

    stub_request(:get, Gplaces::AUTOCOMPLETE_URI + "json?input=Vict&key=INVALID&sensor=true")
      .to_return(body: fixture('error_request_denied.json'), headers: {:content_type => "application/json; charset=utf-8"})

    stub_request(:get, Gplaces::PLACE_DETAILS_URI + "json?key=API&language=en&reference=CmRYAAAAciqGsTRX1mXRvuXSH2ErwW-jCINE1aLiwP64MCWDN5vkXvXoQGPKldMfmdGyqWSpm7BEYCgDm-iv7Kc2PF7QA7brMAwBbAcqMr5i1f4PwTpaovIZjysCEZTry8Ez30wpEhCNCXpynextCld2EBsDkRKsGhSLayuRyFsex6JA6NPh9dyupoTH3g&sensor=true")
      .to_return(body: fixture('details.json'), headers: {:content_type => "application/json; charset=utf-8"})
  end

  let(:client){ Gplaces::Client.new('API') }


  describe 'autocomplete' do
    it "returns a list of predictions" do
      predictions = client.autocomplete('Vict')
      expect(predictions).to be_a(Array)
      expect(predictions.first).to be_a(Gplaces::Prediction)
    end

    describe 'error handling' do
      it "throws an error when API KEY is invalid" do
        g = Gplaces::Client.new('INVALID')
        expect { g.autocomplete('Vict') }.to raise_error(Gplaces::RequestDeniedError)
      end

      it "verifies if input is valid before request" do
        g = Gplaces::Client.new('Valid')
        expect { g.autocomplete('') }.to raise_error(Gplaces::InvalidRequestError)
      end
    end
  end

  describe 'details' do
    let(:place_reference) { 'CmRYAAAAciqGsTRX1mXRvuXSH2ErwW-jCINE1aLiwP64MCWDN5vkXvXoQGPKldMfmdGyqWSpm7BEYCgDm-iv7Kc2PF7QA7brMAwBbAcqMr5i1f4PwTpaovIZjysCEZTry8Ez30wpEhCNCXpynextCld2EBsDkRKsGhSLayuRyFsex6JA6NPh9dyupoTH3g' }
    it 'gets the place details' do
      expect(client.details(place_reference, 'en').formatted_address).to eq('5/48 Pirrama Road, Pyrmont NSW, Australia')
    end

    it 'gets the city name' do
      expect(client.details(place_reference, 'en').city).to eq('Pyrmont')
    end

    it 'is_city is set to false' do
      expect(client.details(place_reference, 'en').is_city).to eq(false)
    end
  end

  describe 'is_city' do
    let(:locality) {["types"=>["locality", "political"]]}
    let(:locality_empty) {}
    it 'returns false when the first element does not include locality as type' do
      address_components = ["types"=>["foo", "bar"]]
      expect(client.is_city(address_components)).to eq(false)
    end

    it 'returns false when there are no elements in the address_components array' do
      expect(client.is_city([])).to eq(false)
    end

    it 'returns false when address_components is nil' do
      expect(client.is_city(nil)).to eq(false)
    end

    it 'returns true when the first element includes locality as type' do
      address_components = ["types"=>["locality", "bar"]]
      expect(client.is_city(address_components)).to eq(true)
    end
  end

end
