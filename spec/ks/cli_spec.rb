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

  describe "#generate" do

    context "when #app_root is nil" do
      it "prints error message" do
        
        msg = "Can't run command outside of working directory"
        
        instance = described_class.new

        expect { instance.generate([]) }.to raise_error(Thor::Error, msg)
        #expect { instance.invoke(:generate) }.to raise_error(Thor::Error, msg)
      end
    end

    context "when .app_root is not nill" do
      include_context "temp_directory"
      
      context "migration" do
        it "creates migration" do
          instance = described_class.new(["migration","new_migration"],{},{:app_root => Dir.mktmpdir})
          expect { instance.generate(*instance.args) }.to output(/     create  db\/migrations\/\d{14}_new_migration.sql/).to_stdout
        end
      end
    end
  end
end