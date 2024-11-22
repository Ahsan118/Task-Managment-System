module Categories
  class Searcher
    attr_accessor :categories

    def self.call(opts = {})
      new(opts).call
    end

    def initialize(opts)
      @opts = opts
      @categories = []
    end

    def call
      @categories = Category.order(updated_at: :desc)
      @categories = @categories.search_by_keyword(keyword) if keyword.present?
      @categories
    end

    private

    def keyword
      @opts[:keyword]
    end
  end
end
