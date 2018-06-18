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

    end
  end
end