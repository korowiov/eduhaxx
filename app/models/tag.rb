class Tag < ApplicationRecord
  include Slugable
  include Admin::TagAdmin
  include Validations::TagValidation

  has_many :resource_tags
end
