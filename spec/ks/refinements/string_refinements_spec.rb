require 'spec_helper'

RSpec.describe KS::StringRefinements do
  using KS::StringRefinements

  describe "#underscore" do
    it "returns \"\"" do
      expect("".underscore).to eq("")
    end

    it "returns a_b_c" do
      expect("A::B::C".underscore).to eq("a_b_c")
    end

    it "returns sample_string" do
      expect("SampleString".underscore).to eq("sample_string")
    end

    it "returns hello_world" do
      expect("hello world".underscore).to eq("hello_world")
    end
  end
end

