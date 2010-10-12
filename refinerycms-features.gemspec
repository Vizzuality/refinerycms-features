Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-features'
  s.version           = '0.2'
  s.description       = 'Ruby on Rails Features engine for Refinery CMS'
  s.date              = '2010-10-12'
  s.summary           = 'Ruby on Rails Features engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'public/**/*']
end
