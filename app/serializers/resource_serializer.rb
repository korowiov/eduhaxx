class ResourceSerializer < Patterns::Serializer
  attributes :id, :name, :description
  belongs_to :education_level
  has_many :subjects

  def type
    object.type.downcase
  end

  class EducationLevelSerializer < Patterns::Serializer
    attributes :slug, :title
  end

  class SubjectSerializer < Patterns::Serializer
    attributes :slug, :title
  end
end
