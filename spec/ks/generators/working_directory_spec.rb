require "spec_helper"
require "thor/parser/options"
require 'tmpdir'

RSpec.describe KS::Generators::WorkingDirectory do

  describe "#generate_working_directory" do
    
    it "creates new empty directory" do
      args, opts = Thor::Options.split(["new_empty_directory"])
      config = {}

      tmp = Dir.mktmpdir('new_empty_directory')
      cwd = Dir.pwd
      Dir.chdir(tmp)

      instance = described_class.new(args,opts,config)
      expect(capture(:stdout) { instance.generate_working_directory }).to include("create  new_empty_directory")

      Dir.chdir(cwd)
      FileUtils.rm_rf(tmp)
    end

  end

end