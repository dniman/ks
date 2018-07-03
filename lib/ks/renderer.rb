require "erb"

module KS
  class Renderer < Thor::Group
    include Thor::Actions

    def render
      Dir.glob(File.join("**", "*.{prc,udf,trg,tab,viw}")).each do |file_name|
        content = File.readlines(file_name).first

        if content =~ /File.read/
          rewrite file_name, content
          say_status :update, relative_to_original_destination_root(File.expand_path(file_name)), {:verbose => true}
        end  
      end
    end

    protected

    def rewrite(file_name,content)
      context = instance_eval('binding')
      File.open(file_name,"w:windows-1251") do |f|
        f.write ERB.new("#{content}").result(context)
      end  
    end

  end
end