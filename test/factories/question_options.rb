FactoryBot.define do
  factory :question_option do
    sequence(:content) { |n| %(question option#{n}) }
    value { 'true' }

    trait :incorrect do
      value { 'false' }
    end
  end
end
