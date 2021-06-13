# frozen_string_literal: true

module Searching
  class BaseService
    def initialize(current_user, search_criteria, limit)
      @current_user = current_user
      @search_criteria = search_criteria
      @resources = []
      @limit = limit
    end
  end
end
