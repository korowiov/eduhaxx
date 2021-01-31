class SubjectRepository
  def initialize(init_scope = nil)
    @scope = init_scope || Subject
  end

  def fetch_parent_nodes
    @scope.where(node_parent_id: nil)
          .order(:title)
  end

  def fetch_with_parents
    @scope.includes(:parent_node)
          .order(:slug)
  end
end
