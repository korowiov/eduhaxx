module Resources
  module Fetch
    class Params
      ATTRS = %w[education_level page phrase sort subjects].freeze

      include ActiveModel::Validations

      attr_reader(*ATTRS)

      validates :page,
                numericality: {
                  only_integer: true,
                  greater_than_or_equal_to: 1
                },
                allow_nil: true
      validates :sort,
                inclusion: { in: %w[date_asc date_desc] },
                allow_nil: true
      validate :valid_education_level_format, if: :education_level?
      validate :valid_subjects_format, if: :subjects?

      def initialize(params = {})
        instance_variables(params.slice(*ATTRS))
      end

      ATTRS.each do |attribute|
        define_method "#{attribute}?" do
          send(attribute).present?
        end
      end

      private

      def instance_variables(params_hsh)
        params_hsh.each do |name, value|
          instance_variable_set("@#{name}", value)
        end
      end

      def valid_education_level_format
        errors.add(:education_level, :invalid) unless education_level.is_a? Array
      end

      def valid_subjects_format
        errors.add(:subjects, :invalid) unless subjects.is_a? Array
      end
    end
  end
end
