require 'thor/group'

module KS
  module Generators
    class WorkingDirectory < Thor::Group
      include Thor::Actions

      argument :name, :type => :string

      def generate_working_directory
        empty_directory name
      end

    end
  end
end  
    