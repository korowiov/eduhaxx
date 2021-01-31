module Statable
  extend ActiveSupport::Concern

  included do
    enum state: {
      created: 'created',
      published: 'published',
      removed: 'removed'
    }

    validates :state, presence: true

    scope :created, -> { where(state: 'created') }
    scope :published, -> { where(state: 'published') }
    scope :removed, -> { where(state: 'removed') }

    def published!
      update({ state: 'published', published_at: DateTime.now })
    end

    def removed!
      update_column(:state, 'removed')
    end

    states.keys.each do |key|
      define_method "#{key}?" do
        send(:state).eql?(key.to_s)
      end
    end
  end
end
