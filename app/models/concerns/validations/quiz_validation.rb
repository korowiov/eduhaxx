module Validations
  module QuizValidation
    extend ActiveSupport::Concern

    included do
      validates_length_of :quiz_questions,
                          minimum: 10,
                          message: 'requires minimum %{count} questions'
    end
  end
end
