module KS

  SRC_EXTENSIONS = {
    :proc => ".prc",
    :func => ".udf",
    :view => ".viw",
    :trig => ".trg",
    :table => ".tab"
  }

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
        "create_procedure" => {:proc => KS::SRC_EXTENSIONS[:proc] },
        "create_function"  => {:func => KS::SRC_EXTENSIONS[:func] },
        "create_view"      => {:view => KS::SRC_EXTENSIONS[:view] },
        "create_trig"      => {:trig => KS::SRC_EXTENSIONS[:trig] },
        "create_table"     => {:table => KS::SRC_EXTENSIONS[:table] },
        "change_procedure" => {:proc => KS::SRC_EXTENSIONS[:proc] },
        "change_function"  => {:func => KS::SRC_EXTENSIONS[:func] },
        "change_view"      => {:view => KS::SRC_EXTENSIONS[:view] },
        "change_trig"      => {:trig => KS::SRC_EXTENSIONS[:trig] },
        "change_table"     => {:table => KS::SRC_EXTENSIONS[:table] },
        "delete_procedure" => {:proc => KS::SRC_EXTENSIONS[:proc] },
        "delete_function"  => {:func => KS::SRC_EXTENSIONS[:func] },
        "delete_view"      => {:view => KS::SRC_EXTENSIONS[:view] },
        "delete_trig"      => {:trig => KS::SRC_EXTENSIONS[:trig] },
        "delete_table"     => {:table => KS::SRC_EXTENSIONS[:table] }
      }

      def migration_file_name
        @migration_file_name ||= "#{migration_path}/#{migration_number}_#{underscored_name}.sql"
      end

      def migration_path
        "db/migrations"
      end

      def migration_number
        @migration_number ||= Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def underscored_name
        name.underscore
      end

      def src_file_name(prefix)
        if directory?
          "src/#{directory}/#{migration_number}_#{name.gsub(/^#{prefix}_/,"")}#{NAME_PREFIXES[prefix].values[0]}.erb"
        else
          "src/#{NAME_PREFIXES[prefix].keys[0].to_s}/#{migration_number}_#{name.gsub(/^#{prefix}_/,"")}#{NAME_PREFIXES[prefix].values[0]}.erb"
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