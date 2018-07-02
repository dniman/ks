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
        let(:config) { {:app_root => Dir.mktmpdir} }
        
        it "creates migration" do
          instance = described_class.new(["migration","new_migration"],{},config)
          expect { instance.generate(*instance.args) }.to output(/     create  db\/migrations\/\d{14}_new_migration.sql/).to_stdout
        end
  
        context "when name begins with create_procedure" do
          it "creates migration and proc file" do
            instance = described_class.new(["migration","create_procedure_new_procedure"],{},config)
              
            expect { instance.generate(*instance.args) }.to output(/\s*create  db\/migrations\/\d{14}_create_procedure_new_procedure.sql\s*create  src\/proc\/new_procedure.prc/).to_stdout
          end

          context "when -d option is specified" do
            it "create proc file inside custom directory" do
              instance = described_class.new(["migration","create_procedure_new_procedure"],{:directory => "some_directory"},config)

              expect { instance.generate(*instance.args) }.to output(/\s*create  src\/proc\/some_directory\/new_procedure.prc/).to_stdout
            end
          end
        end

        context "when name begins with create_function" do
          it "creates migration and func files" do
            instance = described_class.new(["migration","create_function_new_function"],{},config)
              
            expect { instance.generate(*instance.args) }.to output(/\s*create  db\/migrations\/\d{14}_create_function_new_function.sql\s*create  src\/func\/new_function.udf/).to_stdout
          end

          context "when -d option is specified" do
            it "create func file inside custom directory" do
              instance = described_class.new(["migration","create_function_new_function"],{:directory => "some_directory"},config)

              expect { instance.generate(*instance.args) }.to output(/\s*create  src\/func\/some_directory\/new_function.udf/).to_stdout
            end
          end
        end

        context "when name begins with create_view" do
          it "creates migration and view files" do
            instance = described_class.new(["migration","create_view_new_view"],{},config)
              
            expect { instance.generate(*instance.args) }.to output(/\s*create  db\/migrations\/\d{14}_create_view_new_view.sql\s*create  src\/view\/new_view.viw/).to_stdout
          end

          context "when -d option is specified" do
            it "create view file inside custom directory" do
              instance = described_class.new(["migration","create_view_new_view"],{:directory => "some_directory"},config)

              expect { instance.generate(*instance.args) }.to output(/\s*create  src\/view\/some_directory\/new_view.viw/).to_stdout
            end
          end
        end

        context "when name begins with create_trig" do
          it "creates migration and trig files" do
            instance = described_class.new(["migration","create_trig_new_trig"],{},config)
              
            expect { instance.generate(*instance.args) }.to output(/\s*create  db\/migrations\/\d{14}_create_trig_new_trig.sql\s*create  src\/trig\/new_trig.trg/).to_stdout
          end

          context "when -d option is specified" do
            it "create trig file inside custom directory" do
              instance = described_class.new(["migration","create_trig_new_trig"],{:directory => "some_directory"},config)

              expect { instance.generate(*instance.args) }.to output(/\s*create  src\/trig\/some_directory\/new_trig.trg/).to_stdout
            end
          end
        end

        context "when name begins with create_table" do
          it "creates migration and table files" do
            instance = described_class.new(["migration","create_table_new_table"],{},config)
              
            expect { instance.generate(*instance.args) }.to output(/\s*create  db\/migrations\/\d{14}_create_table_new_table.sql\s*create  src\/table\/new_table.tab/).to_stdout
          end

          context "when -d option is specified" do
            it "create table file inside custom directory" do
              instance = described_class.new(["migration","create_table_new_table"],{:directory => "some_directory"},config)

              expect { instance.generate(*instance.args) }.to output(/\s*create  src\/table\/some_directory\/new_table.tab/).to_stdout
            end
          end
        end

      end
    end
  end
end