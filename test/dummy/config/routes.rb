Rails.application.routes.draw do
  mount QuickSearch::DatabaseFinderSearcher::Engine => "/quick_search-database_finder_searcher"
end
