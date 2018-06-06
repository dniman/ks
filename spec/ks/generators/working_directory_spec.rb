require "spec_helper"
require "thor/parser/options"
require 'tmpdir'

RSpec.describe KS::Generators::WorkingDirectory do

  describe "#generate_working_directory" do
    
    before do
      @tmp = Dir.mktmpdir('new_empty_directory')
      @cwd = Dir.pwd
      Dir.chdir(@tmp)
    end

    after do
      Dir.chdir(@cwd)
      FileUtils.rm_rf(@tmp)
    end

    it "creates new empty directory" do
      args, opts = Thor::Options.split(["new_empty_directory"])
      config = {}

      instance = described_class.new(args,opts,config)
      expect { instance.generate_working_directory }.to output(/create  new_empty_directory/).to_stdout
      expect(File.directory?("new_empty_directory")).to be_truthy
    end

    it "creates exe directory" do
      args, opts = Thor::Options.split(["new_empty_directory"])
      config = {}

      instance = described_class.new(args,opts,config)
      expect { instance.generate_exe_files }.to output(/create  new_empty_directory\/exe/).to_stdout
    end

  end

end