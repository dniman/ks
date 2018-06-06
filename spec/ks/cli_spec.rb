require "spec_helper"
require 'tmpdir'

RSpec.describe KS::CLI do

  describe "#new" do
    it "creates new working directory" do
      args, opts = Thor::Options.split(["new","working_directory"])
      config = {}

      tmp = Dir.mktmpdir('working_directory')
      cwd = Dir.pwd
      Dir.chdir(tmp)

      instance = described_class.new(args,opts,config)
      expect{ instance.new("working_directory") }.to output("      create  working_directory\n").to_stdout

      Dir.chdir(cwd)
      FileUtils.rm_rf(tmp)
    end

  end

end