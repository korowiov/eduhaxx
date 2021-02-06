class QuizSession < ApplicationRecord
  has_many :quiz_answers

  belongs_to :quiz

  attribute :configuration, QuizSessionConfiguration.to_type
end
