class QuizSession < ApplicationRecord
  has_many :quiz_answers

  belongs_to :quiz
  belongs_to :account

  attribute :configuration, QuizSessionConfiguration.to_type

  delegate :quiz_questions, to: :quiz
  delegate :questions_order, to: :configuration
end
