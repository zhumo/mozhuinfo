require 'factory_bot'

FactoryBot.define do
  factory :blog do
    sequence(:title) { |n| "Blog Post ##{n}" }
    sequence(:summary) { |n|"You should read this because #{n}" }
    body "Let me tell you about my feelings"
    sequence(:slug) { |n| "slug#{n}" }

    trait :published do
      published_at { Time.zone.now }
    end

    trait :draft do
      published_at nil
    end
  end

  factory :session do
    token { SecureRandom.hex }

    trait :expired do
      created_at { 1.week.ago - 1.hour }
    end
  end
end
