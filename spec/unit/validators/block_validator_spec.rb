require 'spec_helper'

describe 'DataMapper::Validations::ValidatesWithBlock' do
  describe "#validates_with_block" do
    let(:klass) {
      Class.new do
      include DataMapper::Resource
      property :id, DataMapper::Property::Serial
      property :name, String
      validates_with_block(:name, :when => [ :adding ]) do
        if ( name == "Special")
          [false, "fail"]
        else
          true
        end
      end
      end
    }
    subject {klass.new}
    context "when validate in a common situation" do
      it "should be valid" do
        subject.name = "Special"
        subject.should be_valid
      end
    end
    context "when validate in a adding" do
      it "should be valid" do
        subject.name = "Special"
        subject.should_not be_valid(:adding)
      end
    end
  end
end
