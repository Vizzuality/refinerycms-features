class Feature < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :description]

  def self.feature_geom_type
    RefinerySetting.find_or_set(:feature_geom_type, 'point').to_sym
  rescue
    nil
  end

  has_geom :the_geom => self.feature_geom_type if self.feature_geom_type

  validates_presence_of :title
  validates_presence_of :the_geom
  validates_uniqueness_of :title

  serialize :meta, Hash

  belongs_to :gallery

  DEFAULT_ATTRIBUTES = <<-ATT
region:string
country:string
ATT

  # Feature Attributes
  #  List of attributes generated dynamically
  #  Supported types: integer, string, text
  def self.dynamic_attributes
    if RefinerySetting.get(:feature_attributes).nil?
      self.set_default_refinery_attributes
    end
    RefinerySetting.get(:feature_attributes).split("\n").map do |att_type|
      att, type = att_type.split(':')
      [att.strip, type.strip]
    end
  rescue
    []
  end

  def self.set_default_refinery_attributes
    RefinerySetting.set(:feature_attributes, DEFAULT_ATTRIBUTES)
  end

  # Define the getter of the dynamic attributes
  self.dynamic_attributes.each do |att, type|
    define_method att.to_sym do
      self.meta ||= {}
      self.meta[att.to_sym] || nil
    end
  end

  def to_json_attributes
    attributes = {
      :title => self.title,
      :description => self.description,
      :lat => self.the_geom.lat,
      :lon => self.the_geom.lon,
    }
    self.class.dynamic_attributes.each do |att, type|
      attributes[att.to_sym] = send(att.to_sym)
    end
    if gallery && gallery.gallery_entries.count > 0
      attributes[:image_url] = gallery.gallery_entries.first.image.thumbnail(:medium).url
    end
    attributes
  end

  # Define the setter of the dynamic attributes
  self.dynamic_attributes.each do |att, type|
    define_method "#{att}=" do |value|
      self.meta ||= {}
      self.meta[att.to_sym] = value
    end
  end

  def self.srid
    RefinerySetting.find_or_set(:feature_srid, '4326').to_i
  end

  def the_geom=(value)
    from_wkt_to_geom = ActiveRecord::Base.connection.execute("select ST_GeomFromText('#{value}', #{self.class.srid})")[0]['st_geomfromtext']
    write_attribute(:the_geom, from_wkt_to_geom)
  end

  def the_geom_to_wkt
    return nil if self.new_record?
    ActiveRecord::Base.connection.execute("select ST_AsText(the_geom) from features where id = #{self.id}")[0]['st_astext']
  end

end
