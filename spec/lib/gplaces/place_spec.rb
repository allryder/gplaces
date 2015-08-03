RSpec.describe Gplaces::Place do
  it "has a place id" do
    place = described_class.new(
      place_id: "ChIJc1aq0AlaqEcRIiiPcWPAhIw"
    )

    expect(place.place_id).to eq("ChIJc1aq0AlaqEcRIiiPcWPAhIw")
  end

  it "has a location" do
    place = described_class.new(
      geometry: {
        location: {
          lat: "-33.8669330",
          lng: "151.1957910"
        }
      }
    )

    expect(place.location.lat).to eq(-33.8669330)
    expect(place.location.lng).to eq(151.1957910)
  end

  it "has a city" do
    place = described_class.new(
      address_components: [
        {
          long_name:  "Long Name",
          short_name: "SN",
          types:      %w(locality political),
        },
      ]
    )

    expect(place.city).to eq("Long Name")
  end
end
