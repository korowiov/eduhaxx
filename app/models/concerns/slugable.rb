module Slugable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true, uniqueness: true
    before_validation :set_slug, only: %i[create update]
  end

  private

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

  def generate_slug(counter)
    ''.tap do |elements|
      if defined? parent_node
        elements << parent_node.slug + ' ' if parent_node.present?
      end
      elements << if defined? title
                    title + ' '
                  else
                    label + ' '
                  end
      elements << counter if counter.positive?
    end.parameterize
  end

  def should_set_slug?
    new_record? || (defined?(parent_node) && node_parent_id_changed?)
  end
end
