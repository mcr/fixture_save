Gem::Specification.new do |s|
  s.name        = 'fixture_save'
  s.version     = '0.0.1'
  s.date        = '2017-08-22'
  s.summary     = "Fixture Save provides a way to capture production data to fixtures for use in tests"
  s.description = "Fixture Save is a module you add to Rails models to make it easy to save them to YAML files, along with related associated models"
  s.authors     = ["Michael Richardso"]
  s.email       = 'mcr@sandelman.ca'
  s.files       = ["lib/fixture_save.rb", "lib/fixture_save/fixture_writer.rb"]
  s.homepage    = 'http://www.sandelman.ca/gems/fixturesave'
  s.license     = 'Apache-2.0'
end
