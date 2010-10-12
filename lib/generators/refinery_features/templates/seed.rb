User.find(:all).each do |user|
  user.plugins.create(:name => "features",
                      :position => (user.plugins.maximum(:position) || -1) +1)
end

page = Page.create(
  :title => "Features",
  :link_url => "/features",
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => "^/features(\/|\/.+?|)$"
)
Page.default_parts.each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end

RefinerySetting.find_or_set(:feature_srid, '4326')