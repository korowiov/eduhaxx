class QuizQuestion < ApplicationRecord
  enum question_type: {
    single_pick_type: 'single_pick_type',
    multiple_pick_type: 'multiple_pick_type',
    boolean_pick_type: 'boolean_pick_type'
  }

  has_many :question_options, inverse_of: :quiz_question
  belongs_to :quiz, inverse_of: :quiz_questions

  accepts_nested_attributes_for :question_options, allow_destroy: true
end
