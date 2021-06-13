# frozen_string_literal: true

module Searching
  module ByEntity
    class CustomersService < Searching::BaseService
      attr_reader :current_user, :search_criteria

      def perform
        current_user.company.customers.where('lower(name) LIKE ?',
                                             "%#{search_criteria.downcase}%").where(active: true)
      end
    end
  end
end
