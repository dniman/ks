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

      def generate_proc_file
        if name.match?(/^create_procedure_/)
          create_file proc_file_name
        end
      end  

      protected

      def migration_file_name
        "#{migration_path}/#{migration_number}_#{underscored_name}.sql"
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

      def proc_file_name
        "#{proc_path}/#{name.gsub(/create_procedure_/,"")}.prc"
      end

      def proc_path
        "src/proc"
      end
    end
  end
end