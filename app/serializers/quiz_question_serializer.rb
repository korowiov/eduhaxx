class QuizQuestionSerializer < Patterns::Serializer
  attributes :id, :content, :question_type
  has_many :quiz_question_options

  class QuizQuestionOptionSerializer < Patterns::Serializer
    attributes :id, :content
  end
end
