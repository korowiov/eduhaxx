class Quiz < Resource
  include Admin::QuizAdmin
  include Validations::QuizValidation

  has_many :quiz_questions, inverse_of: :quiz
  has_many :resource_subjects, foreign_key: :resource_id
  has_many :subjects, through: :resource_subjects
  has_many :resource_tags, foreign_key: :resource_id
  has_many :tags, through: :resource_tags

  accepts_nested_attributes_for :quiz_questions, allow_destroy: true
end
