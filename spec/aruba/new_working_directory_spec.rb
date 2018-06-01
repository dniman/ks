require 'spec_helper'
require 'aruba/rspec'

RSpec.describe "New working directory", :type => :aruba do
  
  context "when not inside working_directory" do
    it "creates new working directory" do
      run 'ks new working_directory'
      expect(last_command_started).to have_output(/create  /)
      expect(last_command_started).to have_output(/create  Gemfile/)
      expect(last_command_started).to have_output(/create  exe/)
      expect(last_command_started).to have_output(/create  exe\/ks/)
      expect(last_command_started).to have_output(/create  db/)
      expect(last_command_started).to have_output(/create  src/)
    end
  end

end