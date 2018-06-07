require 'thor/group'
require 'ks/refinements'

module KS
  module Generators
    class WorkingDirectory < Thor::Group
      include Thor::Actions
      using StringRefinements

      argument :name, :type => :string

      def self.source_root(path=nil)
        @_source_root = path if path
        @_source_root ||= File.join(base_dirname, "templates", class_name.underscore)
      end

      def generate_working_directory
        empty_directory name
      end

      def generate_exe_files
        directory "exe","#{name}/exe" do |content|
          content
        end
      end

      protected

      def self.class_name
        self.name.to_s.split("::").last
      end

      def self.base_dirname
        File.dirname(__FILE__)
      end
    end
  end
end  
    