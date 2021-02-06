module Admin
  module QuizQuestionAdmin
    extend ActiveSupport::Concern

    included do
      def question_type_enum
        QuizQuestion
          .question_types
          .map do |key, value|
            [key.gsub('_', ' '), value]
          end
      end

      rails_admin do
        create do
          field :quiz
          field :question_type, :enum do
            enum_method do
              :question_type_enum
            end
            label do
              'Question type'
            end
          end
          field :content
          field :question_options
        end

        list do
          fields :id, :quiz
          field :question_type do
            pretty_value do
              value
                .gsub('_', ' ')
            end
          end
          field :content
        end
      end
    end
  end
end
