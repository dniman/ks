require "spec_helper"
require 'tmpdir'

RSpec.describe KS::Generators::Migration do

  describe "#generate_migration" do
    include_context "temp_directory"

    let(:instance) { described_class.new(["migration_file"]) }

    it "creates migration file" do
      allow(instance).to receive(:migration_number).and_return("1234")
      
      instance.shell.mute do
        instance.generate_migration
      end
 
      expect(File.exist?("db/migrations/1234_migration_file.sql")).to be_truthy
    end
  
    it "prints output message" do
      expect { instance.generate_migration }.to output(/create  db\/migrations\/\d{14}_.*/).to_stdout
    end

  end

end

