Temporality [![Build Status](https://secure.travis-ci.org/davout/temporality.png?branch=master)](http://travis-ci.org/davout/temporality) [![Coverage Status](https://img.shields.io/coveralls/davout/temporality.svg)](https://coveralls.io/r/davout/temporality?branch=master) [![Gem Version](https://badge.fury.io/rb/temporality.svg)](http://badge.fury.io/rb/temporality)
=

## What is Temporality
Temporality adds the ability to `ActiveRecord::Base` descendants to validate temporal data on themselves, and their associations.

## Target features
- Completeness implique prevent_overlap! implique également d'être deferred jusqu'au commit de la transaction
- Enforce this is only used on belong_to associations
- Doit permettre de valider que le parent est rempli
- Doit permettre au parent de valider que les enfants sont inclus
- Doit ne pas permettre l'overlap des records enfants

- Doit faire l'auto-close des records précédents, avec callbacks
- Doit faire l'auto-close des enfants, avec callbacks
- Doit permettre d'initialiser l'enfant avec les bornes du parent en faisant par exemple parent.children.build
- Scopes AR : intersecting, contained, englobant
- Quand les bornes du parent sont changées on doit jouer les validations de l'enfant, sinon dans les autres cas, c'est l'enfant qu'on valide
- Que se passe-t-il quand on modifie les bornes du parent, mais qu'on modifie en même temps les bornes de l'enfant ?

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

