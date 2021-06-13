# frozen_string_literal: true

module ::Searching
  class ByAllEntitiesService < Searching::BaseService
    attr_reader :current_user, :search_criteria, :limit

    def perform
      @customers = ::Searching::ByEntity::CustomersService.new(current_user, search_criteria, limit).perform
      @users = ::Searching::ByEntity::UsersService.new(current_user, search_criteria, limit).perform
      @tasks = ::Searching::ByEntity::TasksService.new(current_user, search_criteria, limit).perform

      if current_user.use_resources?
        @resources = ::Searching::ByEntity::ResourcesService.new(current_user, search_criteria,
                                                                 limit).perform
      end

      @projects = ::Searching::ByEntity::ProjectsService.new(current_user, search_criteria, limit).perform

      result
    end

    private

    def result
      { tasks: @tasks, users: @users, customers: @customers, resources: @resources, projects: @projects, limit: @limit }
    end
  end
end
