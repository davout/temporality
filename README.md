Temporality [![Build Status](https://secure.travis-ci.org/davout/temporality.png?branch=master)](http://travis-ci.org/davout/temporality) [![Coverage Status](https://img.shields.io/coveralls/davout/temporality.svg)](https://coveralls.io/r/davout/temporality?branch=master) [![Gem Version](https://badge.fury.io/rb/temporality.svg)](http://badge.fury.io/rb/temporality)
=

## What is Temporality
Temporality adds the ability to `ActiveRecord::Base` descendants to validate temporal data on themselves, and their associations.

## Examples

````ruby
Temporality.configure do |config|
  config.error_strategy = :exception
end

Temporality.configure do |config|
  config.error_strategy = :active_model
end

class Contract < ActiveRecord::Base
  has_many :compensations
end

class Compensation < ActiveRecord::Base
  belongs_to :contract, temporality: { inclusion: true, auto_close_previous: true, allow_overlap: false, completeness: true }
end
````

