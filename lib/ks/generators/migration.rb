module KS
  module Generators
    class Migration < Thor::Group
      include Thor::Actions
      using StringRefinements

      argument :name, :type => :string

      def generate_migration
        context = instance_eval('binding')
        create_file migration_file_name do
          ERB.new("-- file #{migration_file_name}").result(context)
        end
      end

      def generate_src_file
        NAME_PREFIXES.keys.each do |prefix|
          if name.match?(/^#{prefix}_/)
            create_file src_file_name(prefix) do
              "<%= File.read(\"#{migration_file_name}\") %>"
            end
          end
        end
      end

      protected

      NAME_PREFIXES = {
        "create_procedure" => {:proc => ".prc" },
        "create_function"  => {:func => ".udf"},
        "create_view"      => {:view => ".viw"},
        "create_trig"      => {:trig => ".trg"},
        "create_table"     => {:table => ".tab"},
        "change_procedure" => {:proc => ".prc" },
        "change_function"  => {:func => ".udf"},
        "change_view"      => {:view => ".viw"},
        "change_trig"      => {:trig => ".trg"},
        "change_table"     => {:table => ".tab"},
        "delete_procedure" => {:proc => ".prc" },
        "delete_function"  => {:func => ".udf"},
        "delete_view"      => {:view => ".viw"},
        "delete_trig"      => {:trig => ".trg"},
        "delete_table"     => {:table => ".tab"},
      }

      def migration_file_name
        @migration_file_name ||= "#{migration_path}/#{migration_number}_#{underscored_name}.sql"
      end

      def migration_path
        "db/migrations"
      end

      def migration_number
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def underscored_name
        name.underscore
      end

      def src_file_name(prefix)
        if directory?
          "src/#{directory}/dbo.#{name.gsub(/^#{prefix}_/,"")}#{NAME_PREFIXES[prefix].values[0]}"
        else
          "src/#{NAME_PREFIXES[prefix].keys[0].to_s}/dbo.#{name.gsub(/^#{prefix}_/,"")}#{NAME_PREFIXES[prefix].values[0]}"
        end  
      end

      def directory?
        !!options[:directory]
      end

      def directory
        options[:directory]
      end
    end
  end
end