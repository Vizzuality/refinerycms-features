# Refinery CMS Features

A plugin for [Refinery CMS](http://refinerycms.com/) to manage features. Features are small pieces of information geolocated.

## Installation

Add the following line to your `Gemfile` file:

    gem 'refinerycms-features', '= 0.2', :require => 'features', :git => 'git://github.com/Vizzuality/refinerycms-features.git'

And then run `bundle install`.

Now you'll be able to use the generator `refinery_features`:

    script/rails generate refinery_features

This will create a migration and a `seeds` file.

Then run:

    rake db:migrate

And the plugin will be ready to use.

## Feature model

An event is very simple:

  - `title` (_string_)
  - `description` (_text_)
  - `the_geom` (_geometry_)
  - `meta` (_text_)
  - `gallery_id` (_integer_)

## Meta field

`meta` field serializes all the metainformation, in a document-style object. It is used in combination with the Refinery setting `:feature_attributes`, which contains a list of all the attributes and their type. For example:

    location:string
    country:string
    references:text

All this fields are automatically added as _getters_ and _setters_.

## TheGeom field

`the_geom` field contains all the geometric information related with the feature. Depending on the value of the Refinery setting `:feature_geom_type`, it will be a point, a polygon, and so on...
