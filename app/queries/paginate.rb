class Paginate
  attr_reader :relation, :per, :page

  def initialize(relation, params = {})
    @relation = relation
    @page = params.fetch(:page, 1).to_i
    @per = params.fetch(:per, 20).to_i
  end

  def perform
    relation.offset(offset_by).limit(limit_by)
  end

  private

  def offset_by
    return 0 if page <= 1
    (page - 1) * limit_by
  end

  def limit_by
    return 20 unless (1..20).cover? per
    per
  end
end
