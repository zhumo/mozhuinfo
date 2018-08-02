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

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:phone_number) { |n| "#{n}".rjust(10,"0") }
  end

  factory :ping do
    sequence(:algorithm) { |n| Ping::YEARLY_ALGORITHM }
    sequence(:message) { |n| "Read me! #{n}" }

    user

    trait :next_message_scheduled do
      sequence(:next_message_at) { |n| Time.zone.now + n.days }
    end
  end
end
