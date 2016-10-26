module Temporality

  #
  # Defines a +temporality+ migration helper for use in a +create_table+ block as well
  # as a +temporality(:table)+ helper to be used to alter existing table definitions.
  #
  module Schema

    def self.include_helpers!
      if Object.const_defined?(:ActiveRecord)
        ActiveRecord::Migration.send(:include, MigrationHelper)
        ActiveRecord::ConnectionAdapters::TableDefinition.send(:include, TableDefinitionHelper)
      end
    end

    module MigrationHelper
      def temporality(table)
        add_column(table, :starts_on, :date, null: false)
        add_column(table, :ends_on, :date, null: false)
      end
    end

    module TableDefinitionHelper
      def temporality
        date(:starts_on, null: false)
        date(:ends_on, null: false)
      end
    end

  end
end

Temporality::Schema.include_helpers!

