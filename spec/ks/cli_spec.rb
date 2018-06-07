require "spec_helper"

RSpec.describe KS::CLI do
  describe "#new" do
    
    let(:args) { Thor::Options.split(["new","working_directory"])[0] }
    let(:opts) { Thor::Options.split(["new","working_directory"])[1] }
    let(:config) { Hash.new }

    context "when .app_root is unset" do  
      include_context "working_directory"
      
      it "creates new working directory" do
        msg = <<-MSG
      create  working_directory
      create  working_directory/exe
      create  working_directory/exe/ks
        MSG

        instance = described_class.new(args,opts,config)
        expect{ instance.new("working_directory") }.to output("#{msg}").to_stdout
      end
    end

    context "when .app_root is set" do
      include_context "working_directory"
 
      it "prints error message" do
        instance = described_class.new(args,opts,config)
        allow(described_class).to receive(:app_root).and_return(Dir.mktmpdir)

        msg = <<~MSG
          Can't generate a new working directory within the directory of another, please change to a non-working directory first.
          For details run: ks --help
        MSG
        
        expect{ instance.new("working_directory") }.to raise_error(Thor::Error, msg)
      end
    end
  end

end