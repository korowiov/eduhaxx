module Slugable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true, uniqueness: true
    before_validation :set_slug, only: %i[create update]
  end

  private

  def generate_slug(counter)
    ''.tap do |elements|
      elements << parent_node.slug + ' ' if parent_node.present?
      elements << title + ' '
      elements << counter if counter.positive?
    end.parameterize
  end

  def set_slug
    if should_set_slug?
      counter = 0
      self.slug =
        loop do
          generated_slug = generate_slug(counter)

          break generated_slug unless self.class.exists?(slug: generated_slug)

          counter += 1
        end
    end
  end

  def should_set_slug?
    new_record? || node_parent_id_changed?
  end
end