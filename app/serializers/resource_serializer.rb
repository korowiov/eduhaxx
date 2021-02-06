class ResourceSerializer < Patterns::Serializer
  attributes :id, :name, :description
  belongs_to :author
  belongs_to :education_level
  has_many :subjects
  attribute :type

  def type
    object.type.downcase
  end

  class AccountSerializer < Patterns::Serializer
    attributes :id, :nickname
  end

  class EducationLevelSerializer < Patterns::Serializer
    attributes :slug, :title
  end

  class SubjectSerializer < Patterns::Serializer
    attributes :slug, :title
  end
end
