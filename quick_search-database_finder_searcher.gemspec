$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "quick_search/database_finder_searcher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "quick_search-database_finder_searcher"
  s.version     = QuickSearch::DatabaseFinderSearcher::VERSION
  s.authors     = ["David P. Steelman"]
  s.email       = ["dsteelma@umd.edu"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of QuickSearch::DatabaseFinderSearcher."
  s.description = "TODO: Description of QuickSearch::DatabaseFinderSearcher."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.5"

  s.add_development_dependency "sqlite3"
end
