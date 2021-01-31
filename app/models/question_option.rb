class QuestionOption < ApplicationRecord
  belongs_to :quiz_question, inverse_of: :question_options
end
