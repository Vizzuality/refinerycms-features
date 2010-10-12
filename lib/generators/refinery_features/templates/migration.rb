class CreateFeatures < ActiveRecord::Migration

  def self.up
    create_table :features do |t|
      t.string :title
      t.text :description
      t.integer :gallery_id
      t.geometry :the_geom, :srid => 4326, :null => false
      t.integer :position
      t.text :meta

      t.timestamps
    end

    add_index :features, :id

    load(Rails.root.join('db', 'seeds', 'features.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "Features"})

    Page.delete_all({:link_url => "/features"})

    drop_table :features
  end

end
