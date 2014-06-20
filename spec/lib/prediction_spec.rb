require 'spec_helper'

describe Gplaces::Prediction do
  subject { described_class.new(description: 'desc', reference: 'ref', id: 'id', terms: [], matched_substrings: ['subs'])}

  its(:description){ should == 'desc'}
  its(:reference){ should == 'ref'}
  its(:id){ should == 'id'}
  its(:terms){ should  == []}
  its(:matched_substrings){ should == ['subs']}

end
