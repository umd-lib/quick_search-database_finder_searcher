# frozen_string_literal: true

require 'test_helper'

module QuickSearch
  class DatabaseFinderSearcher
    # DatabaseFinderSearch tests
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, QuickSearch::DatabaseFinderSearcher
      end
    end
  end
end
