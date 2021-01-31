class Quiz < Resource
  include Admin::QuizAdmin

  has_many :quiz_questions, inverse_of: :quiz
  has_many :resource_subjects, foreign_key: :resource_id
  has_many :subjects, through: :resource_subjects

  accepts_nested_attributes_for :quiz_questions, allow_destroy: true
end
