module Paginate
  class MetaData
    def initialize(relation, path, params)
      @relation = relation
      @path = path
      @page = params.fetch(:page, 1).to_i
      @size = params.fetch(:size, 20).to_i
    end

    def call
      {
        pagination: {
          page_number: current_page,
          size: per_page,
          total_records: total_records,
          total_pages: total_pages,
          links: links
        }
      }
    end

    private

    attr_reader :relation, :path, :page, :size

    def links
      previous_page_link.merge(next_page_link).merge(self_link)
    end

    def self_link
      {
        self: "#{path}?page=#{current_page}&size=#{per_page}"
      }
    end

    def next_page_link
      return {} if next_page >= total_pages
      {
        next: "#{path}?page=#{next_page}&size=#{per_page}"
      }
    end

    def previous_page_link
      return {} if current_page.zero?
      {
        prev: "#{path}?page=#{previous_page}&size=#{per_page}"
      }
    end

    def total_records
      @total_pages ||= relation.size
    end

    def total_pages
      (total_records / per_page.to_f).ceil
    end

    def current_page
      return 0 if page.negative?
      page
    end

    def next_page
      return 1 if page.negative?
      page + 1
    end

    def previous_page
      page - 1
    end

    def per_page
      return 20 unless (1..20).cover? size
      size
    end
  end
end
