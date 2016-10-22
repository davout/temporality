module Temporality
  module MigrationHelpers

    def temporality(table = nil)
      if table
        add_column(table, :starts_on, :date, null: false)
        add_column(table, :ends_on, :date, null: false)
      else
        date(:starts_on, :date, null: false)
        date(:ends_on, :date, null: false)
      end
    end

  end
end

