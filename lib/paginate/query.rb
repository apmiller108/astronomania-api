module Paginate
  class Query
    def initialize(relation, params = {})
      @relation = relation
      @page = params.fetch(:page, 0).to_i
      @size = params.fetch(:size, 20).to_i
    end

    def call
      relation.offset(offset_by).limit(limit_by)
    end

    private

    attr_reader :relation, :size, :page

    def offset_by
      return 0 if page <= 0
      page * limit_by
    end

    def limit_by
      return 20 unless (1..20).cover? size
      size
    end
  end
end
