RSpec.describe Gplaces::Place do
  let(:place) do
    described_class.new(formatted_address: "My address",
                        geometry: { location: { lat: "-33.8669330", lng: "151.1957910" } })
  end

  it "has a formatted address" do
    expect(place.formatted_address).to eq("My address")
  end

  it "has lat and lng" do
    expect(place.location.lat).to eq(-33.8669330)
    expect(place.location.lng).to eq(151.1957910)
  end
end
