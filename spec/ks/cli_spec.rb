require "spec_helper"

RSpec.describe KS::CLI do
  describe "#new" do
    
    let(:instance) { described_class.new(["working_directory"],{},{}) }

    context "when .app_root is unset" do  
      include_context "temp_directory"
      
      it "creates new working directory" do
        msg = <<-MSG
      create  working_directory
      create  working_directory/exe
      create  working_directory/exe/ks
        MSG

        expect { instance.invoke(:new) }.to output("#{msg}").to_stdout
      end
    end

    context "when .app_root is set" do
      include_context "temp_directory"
 
      it "prints error message" do

        msg = <<~MSG
          Can't generate a new working directory within the directory of another, please change to a non-working directory first.
          For details run: ks --help
        MSG
        
        instance = described_class.new(["working_directory"],{},{:app_root => "some path"})

        expect{ instance.invoke(:new) }.to raise_error(Thor::Error, msg)
      end
    end
  end

end