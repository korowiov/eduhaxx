module Patterns
  class Action
    class MissingAttribute < StandardError; end

    include Patterns::Services

    delegate :errors, :model, to: :form
    delegate :form_klass, :model_klass, to: :"self.class"

    alias resource model

    class << self
      def set_form_klass(form_klass)
        @form_klass = form_klass
      end

      def form_klass
        raise MissingAttribute if @form_klass.nil?

        @form_klass
      end

      def set_model_klass(model_klass)
        @model_klass = model_klass
      end

      def model_klass
        raise MissingAttribute if @model_klass.nil?

        @model_klass
      end
    end

    def initialize(params = {})
      @params = params
    end

    def call
      form.validate(params) && form.save
    end

    protected

    attr_reader :params

    def form
      @form ||=
        form_klass.new(model_klass.new)
    end
  end
end
