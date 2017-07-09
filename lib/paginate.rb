require_relative 'paginate/query'
require_relative 'paginate/meta_data'

module Paginate
  def self.for(relation:, path:, params:)
    results.new(
      Query.new(relation, params).call,
      MetaData.new(relation, path, params).call
    )
  end

  def self.results
    Struct.new(:records, :meta_data)
  end
end
