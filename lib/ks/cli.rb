require 'thor'
require 'ks/generators/working_directory'

module KS
  class CLI < Thor

    #class << self
    #  attr_reader :app_root

    #  def start(given_args = ARGV, config={})
    #    @app_root = config[:app_root]
    #    super
    #  end
    #end

    desc "new [NAME]", "Generate a new ks working directory"
    def new(*args)

      msg = <<~MSG
        Can't generate a new working directory within the directory of another, please change to a non-working directory first.
        For details run: ks --help
      MSG

      raise Error,msg if app_root
      KS::Generators::WorkingDirectory.start(args)
    end


    def initialize(args = [], local_options = {}, config = {})
      @app_root = config[:app_root]
      super
    end

    attr_reader :app_root
  end
end  