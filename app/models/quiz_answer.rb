class QuizAnswer < ApplicationRecord
  belongs_to :quiz_session
  belongs_to :quiz_question
  belongs_to :question_option
end
