# frozen_string_literal: true

module Searching
  module ByEntity
    class TasksService < Searching::BaseService
      attr_reader :current_user, :search_criteria

      def perform
        TaskRecord.all_accessed_by(current_user).where('lower(tasks.name) LIKE ?',
                                                       "%#{search_criteria.downcase}%").where('tasks.status = 0')
      end
    end
  end
end
