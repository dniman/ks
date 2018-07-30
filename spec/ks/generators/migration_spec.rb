require "spec_helper"
require 'tmpdir'

RSpec.describe KS::Generators::Migration do

  describe "#generate_migration" do
    include_context "temp_directory"

    let(:instance) { described_class.new(["migration_file"]) }
    let(:config) { {:directory => "some_directory"} }

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

    context "when -d option is not specified" do
      it "creates proc file" do
        instance = described_class.new(["create_procedure_some_procedure"])
        expect { instance.generate_src_file }.to output(/create  src\/proc\/\d{14}_some_procedure.prc.erb/).to_stdout
      end

      it "creates func file" do
        instance = described_class.new(["create_function_some_function"])
        expect { instance.generate_src_file }.to output(/create  src\/func\/\d{14}_some_function.udf.erb/).to_stdout
      end

      it "creates view file" do
        instance = described_class.new(["create_view_some_view"])
        expect { instance.generate_src_file }.to output(/create  src\/view\/\d{14}_some_view.viw.erb/).to_stdout
      end  
      
      it "creates trg file" do
        instance = described_class.new(["create_trig_some_trig"])
        expect { instance.generate_src_file }.to output(/create  src\/trig\/\d{14}_some_trig.trg.erb/).to_stdout
      end       

      it "creates table file" do
        instance = described_class.new(["create_table_some_table"])
        expect { instance.generate_src_file }.to output(/create  src\/table\/\d{14}_some_table.tab.erb/).to_stdout
      end 
    end

    context "when -d options is specified" do
      it "creates proc file" do
        instance = described_class.new(["create_procedure_some_procedure"],config)
        expect { instance.generate_src_file }.to output(/create  src\/some_directory\/\d{14}_some_procedure.prc.erb/).to_stdout
      end

      it "creates func file" do
        instance = described_class.new(["create_function_some_function"],config)
        expect { instance.generate_src_file }.to output(/create  src\/some_directory\/\d{14}_some_function.udf.erb/).to_stdout
      end

      it "creates view file" do
        instance = described_class.new(["create_view_some_view"],config)
        expect { instance.generate_src_file }.to output(/create  src\/some_directory\/\d{14}_some_view.viw.erb/).to_stdout
      end      

      it "creates trig file" do
        instance = described_class.new(["create_trig_some_trig"],config)
        expect { instance.generate_src_file }.to output(/create  src\/some_directory\/\d{14}_some_trig.trg.erb/).to_stdout
      end 
      
      it "creates table file" do
        instance = described_class.new(["create_table_some_table"],config)
        expect { instance.generate_src_file }.to output(/create  src\/some_directory\/\d{14}_some_table.tab.erb/).to_stdout
      end 
    end

  end  
end
