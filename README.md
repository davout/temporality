Temporal [![Build Status](https://secure.travis-ci.org/davout/temporal.png?branch=master)](http://travis-ci.org/davout/temporal) [![Coverage Status](https://img.shields.io/coveralls/Paymium/gekko.svg)](https://coveralls.io/r/davout/temporal?branch=master) [![Gem Version](https://badge.fury.io/rb/temporal.svg)](http://badge.fury.io/rb/temporal)
=

## What is Temporal
Temporal adds the ability to `ActiveRecord::Base` descendants to validate temporal data on themselves, and their associations.

## Target features
- Doit pouvoir valider la présence de date de début
- Doit pouvoir valider la présence de date de fin
- Doit prévoir des dates par défaut pour le début et la fin (01-01-1500 - 01-01-5000)
- Doit valider que la date de début est antérieure strictement, ou pas, à la date de fin

- Doit s'assurer que les dates ne sont pas nullables en DB
- Doit fournir de helpers de migration (temporal: true, temporal_columns)

- Doit permettre de valider qu'on est inclus dans le parent
- Doit permettre de valider que le parent est rempli (?)

- Doit faire l'auto-close des records précédents, avec callbacks
- Doit faire l'auto-close des enfants, avec callbacks

