FactoryBot.define do
  factory :education_level do
    sequence(:title) { |n| %(level #{n}) }
    sequence(:slug) { |n| %(level-#{n}) }
  end
end
