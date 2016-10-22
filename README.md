Temporality [![Build Status](https://secure.travis-ci.org/davout/temporal.png?branch=master)](http://travis-ci.org/davout/temporal) [![Coverage Status](https://img.shields.io/coveralls/Paymium/gekko.svg)](https://coveralls.io/r/davout/temporal?branch=master) [![Gem Version](https://badge.fury.io/rb/temporal.svg)](http://badge.fury.io/rb/temporal)
=

## What is Temporality
Temporality adds the ability to `ActiveRecord::Base` descendants to validate temporal data on themselves, and their associations.

## Target features
- Doit fournir de helpers de migration (temporal: true, temporal_columns)

- Doit permettre de valider que le parent est rempli
- Doit permettre au parent de valider que les enfants sont inclus
- Doit ne pas permettre l'overlap des records enfants

- Doit faire l'auto-close des records précédents, avec callbacks
- Doit faire l'auto-close des enfants, avec callbacks
- Doit permettre d'initialiser l'enfant avec les bornes du parent en faisant par exemple parent.children.build
- Scopes AR : intersecting, contained, englobant

