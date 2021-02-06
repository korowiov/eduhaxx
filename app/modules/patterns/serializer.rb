module Patterns
  class Serializer < ActiveModel::Serializer

    def attributes(*args)
      hash = super
      hash = hash.slice(*only) if only.present?
      hash
    end

    protected

    def only
      @instance_options[:only]
    end

    def should_render_association?
      only.nil?
    end
  end
end
