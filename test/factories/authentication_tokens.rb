FactoryBot.define do
  factory :authentication_token do
    account { create(:account) }
    sequence(:token) { |n| %(123-123#{n}) }
    sign_in_ip { '0.0.0.1' }
  end
end
