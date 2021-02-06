class SubjectSerializer < Patterns::Serializer
  attributes :title, :slug
  attribute :childrens, if: -> { object.root? }

  def childrens
    (object.children_subjects || []).map do |subject|
      SubjectSerializer.new(subject, root: false).serializable_hash
    end
  end
end
