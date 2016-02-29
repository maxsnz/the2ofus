class SortResources
  include CallableClass
  attr_reader :scope, :ids, :reverse

  # @param [ActiveRecord::Relation] scope
  # @param [Array<String,Integer>] ids
  def initialize(scope, ids, reverse = false)
    @scope = scope
    @ids = Array.wrap(ids)
    @reverse = reverse
  end

  # @return nothing
  def call
    klass.transaction do
      positions = scope.where(id: ids).pluck(:position).sort

      Array.wrap(ids).each_with_index do |id, i|
        index = reverse ? -i-1 : i
        scope.where(id: id).update_all(position: positions[index])
      end
    end
  end

  private

  def klass
    scope.try(:klass) || scope
  end
end
