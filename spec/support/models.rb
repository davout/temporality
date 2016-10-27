# Defines the test models

class Dummy < ActiveRecord::Base
  include Temporality
end

class Person < ActiveRecord::Base
  include Temporality
  has_many :dogs, extend: Temporality::AssociationExtensions
end

class Dog < ActiveRecord::Base
  include Temporality
  belongs_to :person,
    inverse_of: :dogs,
    temporality: { inclusion: true, auto_close: false, prevent_overlap: true, completeness: false }
end


