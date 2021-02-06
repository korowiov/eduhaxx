module Admin
  module QuizAdmin
    extend ActiveSupport::Concern

    included do
      before_validation do
        self.subject_ids = subject_ids.reject(&:blank?)
      end

      rails_admin do
        create do
          fields :name, :description
          field :education_level do
            inline_add false
            inline_edit false
          end
          field :subjects do
            inline_add false
          end
          field :tags
          field :quiz_questions
        end

        edit do
          fields :name, :description
          field :education_level do
            inline_add false
            inline_edit false
          end
          field :subjects do
            inline_add false
          end
          field :tags
          field :quiz_questions
        end

        list do
          fields :id, :education_level, :name, :description, :state
        end
      end
    end
  end
end
