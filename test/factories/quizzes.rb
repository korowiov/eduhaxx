FactoryBot.define do
  factory :quiz do
    education_level
    sequence(:name) { |n| %(quiz title #{n}) }
    sequence(:description) { |n| %(quiz description #{n}) }
    subjects { create_list(:subject, 2) }

    trait :published do
      state { 'published' }
      sequence(:published_at) { |n| DateTime.now + n.minutes }
    end
  end
end
