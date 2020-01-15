# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
module QuickSearch
  # QuickSearch searcher for Database Finder
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
        content_tag(:i, '', class: %w[fa fa-lock]),
        'https://www.lib.umd.edu/services/remote-access',
        class: ['restricted tiny'],
        remote: true
      )
    end

    def build_info_link(href)
      link_to(content_tag(:i, '', class: %w[fa fa-lock]),
              href,
              class: ['info tiny'],
              remote: true)
    end

    def build_description_block(desc)
      content_tag(:div, raw(desc), class: ['block-with-text'])
    end

    def results # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      return @results_list if @results_list

      @results_list = @response['resultList'].map do |value|
        # We want to show a result even if it doesn't have a hostUrl
        # (some Database Finder entries point to services that are no
        # no longer available, but are kept for historical/informational
        # purposes). Since the NCSU QuickSearch code wants to suppress
        # results without hostUrls, we'll default to "#" if the
        # result doesn't have one.
        host_url = value['hostUrl'].presence || '#'

        info_link = value['detailLink']
        restricted = value['restricted']
        open_access = value['openAccess']

        result = OpenStruct.new(title: value['name'],
                                link: host_url,
                                description: build_description_block(value['description']),
                                date: build_info_link(info_link))

        # The following is a kludge to display the "i" and "lock" icons
        # in the searchumd QuickSearch GUI.
        result.date << build_restricted_link if restricted

        result.restricted = restricted
        result.info_link = info_link
        result.item_format = 'database'
        result.open_access = open_access
        result
      end

      @results_list
    end

    def search_url
      QuickSearch::Engine::DATABASE_FINDER_CONFIG['search_url'] +
        QuickSearch::Engine::DATABASE_FINDER_CONFIG['query_params'] +
        percent_encoded_raw_user_search_query
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::DATABASE_FINDER_CONFIG['loaded_link'] + percent_encoded_raw_user_search_query
    end

    # Returns the percent-encoded search query entered by the user, skipping
    # the default QuickSearch query filtering
    def percent_encoded_raw_user_search_query
      CGI.escape(@q)
    end
  end
end
# rubocop:enable Rails/OutputSafety
