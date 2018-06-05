require 'thor'
require 'ks/generators/working_directory'

module KS
  class CLI < Thor

    desc "new [NAME]", "Generate a new ks working directory"
    def new(*args)
      KS::Generators::WorkingDirectory.start(args)
    end

  end
end  