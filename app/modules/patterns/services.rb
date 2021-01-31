module Patterns
  module Services
    extend ActiveSupport::Concern

    def call
      raise NotImplementedError
    end

    class_methods do
      def call(**args)
        new(**args).call
      end
    end
  end
end
