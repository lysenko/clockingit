# frozen_string_literal: true

module Searching
  class CustomerService
    def initialize(search_criteria, entity, current_user)
      @search_criteria = search_criteria
      @customers = []
      @users = []
      @tasks = []
      @projects = []
      @resources = []
      @entity = entity
      @limit = entity.present? ? 1_000_000 : 5
      @current_user = current_user
    end

    def perform
      raise 'Search term required' if search_criteria.blank?

      if search_criteria.to_i.positive?
        search_all_tasks
      elsif entity
        search_by_entity
      else
        search_by_all_entities
      end
    end

    private

    attr_accessor :search_criteria, :customers, :users, :tasks, :projects, :resources, :limit, :entity, :current_user,
                  :company

    def search_all_tasks
      @tasks = TaskRecord.all_accessed_by(current_user).where(task_num: search_criteria)
    end

    def search_by_entity
      case entity
      when /user/
        @users = ::Searching::ByEntity::UsersService.new(current_user, search_criteria, limit).perform
      when /customer/
        @customers = ::Searching::ByEntity::CustomersService.new(current_user, search_criteria, limit).perform
      when /task/
        @tasks = ::Searching::ByEntity::TasksService.new(current_user, search_criteria, limit).perform
      when /resource/
        if current_user.use_resources?
          @resources = ::Searching::ByEntity::ResourcesService.new(current_user, search_criteria,
                                                                   limit).perform
        end
      when /project/
        @projects = ::Searching::ByEntity::ProjectsService.new(current_user, search_criteria, limit).perform
      end

      result
    end

    def search_by_all_entities
      ::Searching::ByAllEntitiesService.new(current_user, search_criteria, limit).perform
    end

    def result
      { tasks: @tasks, users: @users, customers: @customers, resources: @resources, projects: @projects, limit: @limit }
    end
  end
end
