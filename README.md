# quick_search-database_finder_searcher

Database Finder searcher for NCSU Quick Search

## Installation

1) Include the searcher gem in your Gemfile:

```
gem 'quick_search-database_finder_searcher'
```

2) Run bundle install:

```
bundle install
```

4) Update the config/quick_search_config.yml to include the "database_finder"
   searcher.

3) Include in your Search Results page

```
<%= render_module(@database_finder, 'database_finder') %>
```

## Configuration

Database Finder requires configuration, such as the Hippo CMS to communicate
with. To set the configuration, create a "config/searchers/" directory in your
application (the "searchers" subdirectory may need to be created), and copy the
"config/database_finder_config.yml" file in this gem into it. Follow the
instructions in the file to configure the searcher.

Additional customizations can be done by editing the "config/locales/en.yml" file.
