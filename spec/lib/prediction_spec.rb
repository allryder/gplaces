require 'spec_helper'

describe Gplaces::Prediction do
  def prediction
    described_class.new(
      description:        'description',
      place_id:           'place_id',
      reference:          'reference',
      id:                 'id',
      terms:              [{}],
      matched_substrings: [{}]
    )
  end

  it 'has a description' do
    expect(prediction.description).to eq('description')
  end

  it 'has a place_id' do
    expect(prediction.place_id).to eq('place_id')
  end

  it 'has a reference (deprecated as of June 24, 2014)' do
    expect(prediction.reference).to eq('reference')
  end

  it 'has an id (deprecated as of June 24, 2014)' do
    expect(prediction.id).to eq('id')
  end

  it 'has terms' do
    expect(prediction.terms).to eq([{}])
  end

  it 'has matched_substrings' do
    expect(prediction.matched_substrings).to eq([{}])
  end
end
