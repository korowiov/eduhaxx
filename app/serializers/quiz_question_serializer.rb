class QuizQuestionSerializer < Patterns::Serializer
  attributes :id, :content, :question_type
  has_many :question_options

  class QuestionOptionSerializer < Patterns::Serializer
    attributes :id, :content
  end
end
