class Quiz < Resource
  include Admin::QuizAdmin
  include Validations::QuizValidation

  has_many :quiz_questions, inverse_of: :quiz

  accepts_nested_attributes_for :quiz_questions, allow_destroy: true
end
