class Resource < ApplicationRecord
  include Statable
  include PgSearch::Model
  include Validations::ResourceValidation

  multisearchable against: %i[name description],
                  if: ->(record) { record.published? }

  has_many :resource_subjects, as: :subjectable
  has_many :subjects, through: :resource_subjects

  has_many :resource_tags, as: :taggable
  has_many :tags, through: :resource_tags

  belongs_to :education_level
end
