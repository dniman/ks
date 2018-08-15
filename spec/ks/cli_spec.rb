require "spec_helper"

RSpec.describe KS::CLI do
  describe "#new" do
    context "when .app_root is unset" do  
      it "creates new working directory" do
        instance = described_class.new(["working_directory"],{},{})

        expect(KS::Generators::WorkingDirectory).to receive(:start)
        instance.invoke(:new)
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
        expect { instance.invoke(:generate) }.to raise_error(Thor::Error, msg)
      end
    end

    context "when .app_root is not nill" do
      include_context "temp_directory"
      
      context "migration" do
        let(:config) { {:app_root => Dir.mktmpdir} }
        
        it "creates migration" do
          instance = described_class.new(["migration","new_migration"],{},config)
   
          expect(KS::Generators::Migration).to receive(:start)
          instance.invoke(:generate)
        end
      end
    end
  end

  describe "#render" do
    context "when #app_root is nil" do
      it "prints error message" do
        msg = "Can't run command outside of working directory"
        instance = described_class.new

        expect { instance.render }.to raise_error(Thor::Error, msg)
      end
    end
    
    context "when #app_root is not nil" do
      include_context "temp_directory"
      let(:config) { {:app_root => Dir.mktmpdir} }

      it "updates src files" do
        instance = described_class.new(["render"],{},config)

        expect(KS::Renderer).to receive(:start)
        instance.render
      end

    end
  end

  describe "cvs" do
    context "when #app_root is nil" do
      it "prints error message" do
        msg = "Can't run command outside of working directory"
        
        instance = described_class.new
        expect { instance.invoke(:cvs) }.to raise_error(Thor::Error, msg)
      end
    end
  end
end