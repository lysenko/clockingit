# frozen_string_literal: true

module Searching
  module ByEntity
    class ProjectsService < Searching::BaseService
      attr_reader :current_user, :search_criteria

      def perform
        current_user.projects.where('lower(name) like ?', "%#{search_criteria.downcase}%")
      end
    end
  end
end
