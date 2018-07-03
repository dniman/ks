require "spec_helper"

RSpec.describe KS::Renderer do
  describe "#render" do
    include_context "temp_directory"

    let(:instance) { described_class.new }

    context ".prc file" do
      let(:migration_file) {"procedure.sql"}
      let(:src_file) {"procedure.prc"}

      context "when matching template string" do
        include_context "test_files"

        it "should rewrite file" do
          expect(instance).to receive(:rewrite)
          instance.render
        end

        it "should print update status" do
          expect { instance.render }.to output(/update  procedure.prc/).to_stdout
        end
      end
    end

    context ".udf file" do
      let(:migration_file) {"function.sql"}
      let(:src_file) {"function.udf"}

      context "when matching template string" do
        include_context "test_files"

        it "should rewrite file" do
          expect(instance).to receive(:rewrite)
          instance.render
        end

        it "should print update status" do
          expect { instance.render }.to output(/update  function.udf/).to_stdout
        end

      end
    end    

    context ".viw file" do
      let(:migration_file) {"view.sql"}
      let(:src_file) {"view.viw"}

      context "when matching template string" do
        include_context "test_files"

        it "should rewrite file" do
          expect(instance).to receive(:rewrite)
          instance.render
        end

        it "should print update status" do
          expect { instance.render }.to output(/update  view.viw/).to_stdout
        end

      end
    end

    context ".trg file" do
      let(:migration_file) {"trigger.sql"}
      let(:src_file) {"trigger.trg"}

      context "when matching template string" do
        include_context "test_files"

        it "should rewrite file" do
          expect(instance).to receive(:rewrite)
          instance.render
        end

        it "should print update status" do
          expect { instance.render }.to output(/update  trigger.trg/).to_stdout
        end

      end
    end

    context ".tab file" do
      let(:migration_file) {"table.sql"}
      let(:src_file) {"table.tab"}

      context "when matching template string" do
        include_context "test_files"

        it "should rewrite file" do
          expect(instance).to receive(:rewrite)
          instance.render
        end

        it "should print update status" do
          expect { instance.render }.to output(/update  table.tab/).to_stdout
        end

      end
    end    

  end
end