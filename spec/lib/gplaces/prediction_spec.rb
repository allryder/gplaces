RSpec.describe Gplaces::Prediction do
  let(:prediction) do
    described_class.new(place_id:    "place_id",
                        description: "description")
  end

  it "has a description" do
    expect(prediction.description).to eq("description")
  end

  it "has a place_id" do
    expect(prediction.place_id).to eq("place_id")
  end
end
