require "erb"

module KS
  class Renderer < Thor::Group
    include Thor::Actions

    def render
      Dir.glob(File.join("**", "*.erb")).each do |file_name|
        groups = file_name.match(/(^.*?\D*)\d*\w(.*?).erb/)
        src_file_name = "".concat(groups[1],"dbo.",groups[2])
        content = File.readlines(file_name).first

        if content =~ /File.read/
          write_file_in_encoding src_file_name, content
          say_status :create, relative_to_original_destination_root(File.expand_path(src_file_name)), {:verbose => true}
          write_file_in_encoding file_name, ""
          say_status :erase, relative_to_original_destination_root(File.expand_path(file_name)), {:verbose => true}
        end  
      end
    end

    protected

    def write_file_in_encoding(encoding = "windows-1251",file_name,content)
      context = instance_eval('binding')
      File.open(file_name,"w:#{encoding}") do |f|
        f.write ERB.new("#{content}").result(context).force_encoding(encoding)
      end  
    end

  end
end