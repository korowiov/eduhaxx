class Resource < ApplicationRecord
  include Statable
  include PgSearch::Model
  multisearchable against: %i[name description],
                  if: ->(record) { record.published? }

  belongs_to :education_level
end
