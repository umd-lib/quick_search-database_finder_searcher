# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
module QuickSearch
  # QuickSearch seacher for Database Finder
  class DatabaseFinderSearcher < QuickSearch::Searcher
    include Rails.application.routes.url_helpers
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def build_restricted_link
      link_to(
        content_tag(:i, '', class: ['fa', 'fa-lock']),
        'https://www.lib.umd.edu/services/remote-access',
        class: ['restricted tiny'],
        remote: true
      )
    end

    def build_info_link(href)
      link_to(content_tag(:i, '', class: ['fa', 'fa-info']),
              href,
              class: ['info tiny'],
              remote: true)
    end

    def build_description_block(desc)
      content_tag(:div, raw(desc), class: ['block-with-text'])
    end

    def results
      return @results_list if @results_list
      @results_list = @response['resultList'].map do |value|
        result = OpenStruct.new(title: value['displayName'],
                                link: value['hostUrl'],
                                description: build_description_block(value['description']),
                                date: build_info_link(value['detailLink']))
        result.date << build_restricted_link if value['restricted']
        result
      end

      @results_list
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
# rubocop:enable Rails/OutputSafety
