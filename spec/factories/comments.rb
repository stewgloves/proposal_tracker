FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    proposal { nil }
  end
end
