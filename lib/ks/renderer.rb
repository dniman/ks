require "erb"

module KS
  class Renderer < Thor::Group
    include Thor::Actions

    def render
      Dir.glob(File.join("**", "*.{prc,udf,trg,tab,viw}")).each do |file_name|
        content = File.readlines(file_name).first

        if content =~ /File.read/
          context = instance_eval('binding')
          puts context
          File.write(file_name,ERB.new(content).result(context))
          say_status :update, relative_to_original_destination_root(File.expand_path(file_name)), {:verbose => true}
        end  
      end
    end

  end
end