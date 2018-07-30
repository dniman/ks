require "spec_helper"

RSpec.describe KS::Renderer do
  describe "#render" do
    include_context "temp_directory"

    let(:instance) { described_class.new }
    let(:migration_number){ Time.now.utc.strftime("%Y%m%d%H%M%S") }

    context ".prc file" do
      let(:migration_file) {"#{migration_number}_procedure.sql"}
      let(:src_file) {"#{migration_number}_procedure#{KS::SRC_EXTENSIONS[:proc]}.erb"}

      context "when matching template string" do
        include_context "test_files"

        it "should create file in windows-1251 encoding" do
          expect(instance).to receive(:write_file_in_encoding).at_least(:once)
          instance.shell.mute do 
            instance.render
          end
        end
        
        it "should print create status" do
          expect { instance.render }.to output(/create  dbo.procedure.prc/).to_stdout
        end

        it "should erase erb file" do
          expect(instance).to receive(:write_file_in_encoding).at_least(2).times
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print erase status" do
          expect { instance.render }.to output(/erase  \d{14}_procedure.prc.erb/).to_stdout
        end        
      end
    end

    context ".udf file" do
      let(:migration_file) {"#{migration_number}_function.sql"}
      let(:src_file) {"#{migration_number}_function#{KS::SRC_EXTENSIONS[:func]}.erb"}

      context "when matching template string" do
        include_context "test_files"

        it "should create file in windows-1251 encoding" do
          expect(instance).to receive(:write_file_in_encoding).at_least(:once)
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print create status" do
          expect { instance.render }.to output(/create  dbo.function.udf/).to_stdout
        end

        it "should erase erb file" do
          expect(instance).to receive(:write_file_in_encoding).at_least(2).times
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print erase status" do
          expect { instance.render }.to output(/erase  \d{14}_function.udf.erb/).to_stdout
        end 
      end
    end    

    context ".viw file" do
      let(:migration_file) {"#{migration_number}_view.sql"}
      let(:src_file) {"#{migration_number}_view#{KS::SRC_EXTENSIONS[:view]}.erb"}

      context "when matching template string" do
        include_context "test_files"

        it "should create file in windows-1251 encoding" do
          expect(instance).to receive(:write_file_in_encoding).at_least(:once)
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print create status" do
          expect { instance.render }.to output(/create  dbo.view.viw/).to_stdout
        end

        it "should erase erb file" do
          expect(instance).to receive(:write_file_in_encoding).at_least(2).times
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print erase status" do
          expect { instance.render }.to output(/erase  \d{14}_view.viw.erb/).to_stdout
        end         
      end
    end

    context ".trg file" do
      let(:migration_file) {"#{migration_number}_trigger.sql"}
      let(:src_file) {"#{migration_number}_trigger#{KS::SRC_EXTENSIONS[:trig]}.erb"}

      context "when matching template string" do
        include_context "test_files"

        it "should create file in windows-1251 encoding" do
          expect(instance).to receive(:write_file_in_encoding).at_least(:once)
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print create status" do
          expect { instance.render }.to output(/create  dbo.trigger.trg/).to_stdout
        end

        it "should erase erb file" do
          expect(instance).to receive(:write_file_in_encoding).at_least(2).times
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print erase status" do
          expect { instance.render }.to output(/erase  \d{14}_trigger.trg.erb/).to_stdout
        end         
      end
    end

    context ".tab file" do
      let(:migration_file) {"#{migration_number}_table.sql"}
      let(:src_file) {"#{migration_number}_table#{KS::SRC_EXTENSIONS[:table]}.erb"}

      context "when matching template string" do
        include_context "test_files"

        it "should create file in windows-1251 encoding" do
          expect(instance).to receive(:write_file_in_encoding).at_least(:once)
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print create status" do
          expect { instance.render }.to output(/create  dbo.table.tab/).to_stdout
        end

        it "should erase erb file" do
          expect(instance).to receive(:write_file_in_encoding).at_least(2).times
          instance.shell.mute do 
            instance.render
          end
        end

        it "should print erase status" do
          expect { instance.render }.to output(/erase  \d{14}_table.tab.erb/).to_stdout
        end         
      end
    end    

  end
end