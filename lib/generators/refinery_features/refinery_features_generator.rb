require 'fileutils'

class RefineryFeaturesGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_features.rb'
    template 'seed.rb', Rails.root.join('db/seeds/features.rb')
    FileUtils.cp_r File.expand_path('../../../../public/javascripts', __FILE__), Rails.root.join('public/')
    puts "------------------------"
    puts "Now run:"
    puts "rake db:migrate"
    puts "------------------------"
  end

end