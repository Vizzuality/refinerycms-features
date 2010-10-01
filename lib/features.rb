require 'refinery'

module Refinery
  module Features
    class Engine < Rails::Engine
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "features"
          plugin.activity = {:class => Feature}
        end
      end
    end
  end
end
