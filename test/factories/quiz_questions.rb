FactoryBot.define do
  factory :quiz_question do
    sequence(:content) { |n| %(question content #{n}) }
    question_type { 'single_pick_type' }
    question_options do
      [
        build(:question_option),
        build(:question_option, :incorrect),
        build(:question_option, :incorrect),
        build(:question_option, :incorrect)
      ]
    end

    trait :multiple_pick_type do
      question_type { 'multiple_pick_type' }
      question_options do
        [
          build(:question_option),
          build(:question_option),
          build(:question_option, :incorrect),
          build(:question_option, :incorrect)
        ]
      end
    end
  end
end
