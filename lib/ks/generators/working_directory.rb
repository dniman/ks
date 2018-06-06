require 'thor/group'

module KS
  module Generators
    class WorkingDirectory < Thor::Group
      include Thor::Actions

      argument :name, :type => :string

      public_task :set_source_root!
      
      def generate_working_directory
        empty_directory name
      end

      def generate_exe_files
        directory "exe" do |content|
          content
        end
      end

      protected

      def set_source_root!
        self.source_root = File.join(File.dirname(__FILE__), "templates")
      end

    end
  end
end  
    