class QuizSessionSerializer < Patterns::Serializer
  attributes :id, :questions_order
  has_one :quiz, if: -> { should_render_association? }

  class QuizSerializer < Patterns::Serializer
    attributes :id, :name
  end
end
