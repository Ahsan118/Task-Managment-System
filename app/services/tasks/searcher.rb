module Tasks
  class Searcher
    attr_accessor :tasks

    def self.call(opts = {})
      new(opts).call
    end

    def initialize(opts)
      @opts = opts
      @tasks = []
    end

    def call
      @tasks = Task.with_user_and_category.for_user(current_user).order(updated_at: :desc)

      apply_filters
      @tasks
    end

    private

    def apply_filters
      @tasks = @tasks.search_by_keyword(keyword) if keyword.present?
      @tasks = @tasks.by_category_id(category_id) if category_id.present?
      @tasks = @tasks.by_status(status) if status.present?
      @tasks = filter_by_date_range(@tasks) if date_range.present?
    end

    def filter_by_date_range(tasks)
      start_date, end_date = date_range.split(" - ").map(&:to_date)
      tasks.by_date_range(start_date, end_date)
    end

    def keyword
      @opts[:keyword]
    end

    def category_id
      @opts[:category_id]
    end

    def status
      @opts[:status]
    end

    def current_user
      @opts[:current_user]
    end

    def date_range
      @opts[:date_range]
    end
  end
end
