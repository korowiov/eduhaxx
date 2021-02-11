FactoryBot.define do
  factory :account do
    sequence(:nickname) { |n| %(nickname#{n}) }
    sequence(:email) { |n| %(test#{n}@example.com) }
    password { 'T#est1234' }
    password_confirmation { 'T#est1234' }
  end
end
