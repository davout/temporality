# Defines the test models

class Dummy < ActiveRecord::Base
  include Temporality
end

class Person < ActiveRecord::Base
  include Temporality
  has_many :dogs
end

class Dog < ActiveRecord::Base
  include Temporality
  belongs_to :person, temporality: { inclusion: true, auto_close: true, prevent_overlap: true, completeness: false }, inverse_of: :dogs
end


