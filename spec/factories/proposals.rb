FactoryBot.define do
  factory :proposal do
    title { "MyString" }
    description { "MyText" }
    status { "MyString" }
    user { nil }
    project { nil }
  end
end
