module QuickSearch
  # QuickSearch seacher for Database Finder
  class DatabaseFinderSearcher < QuickSearch::Searcher
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def results # rubocop:disable Metrics/MethodLength
      if results_list
        results_list
      else
        @results_list = []

        search_result_list = @response['resultList']

        search_result_list.each do |value|
          result = OpenStruct.new
          result.title = value['displayName']
          result.link = value['DetailLink']
          result.description = value['Description']
          @results_list << result
        end

        @results_list
      end
    end

    def search_url
      QuickSearch::Engine::DATABASE_FINDER_CONFIG['search_url'] +
        QuickSearch::Engine::DATABASE_FINDER_CONFIG['query_params'] +
        http_request_queries['not_escaped']
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::DATABASE_FINDER_CONFIG['loaded_link'] + http_request_queries['uri_escaped']
    end
  end
end
