require 'spec_helper'

describe Gplaces::Prediction do
  subject { described_class.new(description: 'desc', reference: 'ref', id: 'id', terms: [], matched_substrings: ['subs'])}

  it 'has a description' do
    expect(subject.description).to eq('desc')
  end

  it 'has a reference' do
    expect(subject.reference).to eq('ref')
  end

  it 'has an id' do
    expect(subject.id).to eq('id')
  end

  it 'has terms' do
    expect(subject.terms).to eq([])
  end

  it 'has matched_substrings' do
    expect(subject.matched_substrings).to eq(['subs'])
  end
end
