Rails.application.routes.draw do
  mount QuickSearchDatabaseFinderSearcher::Engine => "/quick_search-database_finder_searcher"
end
