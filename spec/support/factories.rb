require 'factory_girl'

FactoryGirl.define do
  factory :blog do
    sequence(:title) { |n| "Blog Post ##{n}" }
    sequence(:summary) { |n|"You should read this because #{n}" }
    body "Let me tell you about my feelings"

    trait :published do
      published_at { Time.zone.now }
    end
  end
end
