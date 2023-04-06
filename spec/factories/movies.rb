FactoryBot.define do
  factory :movie do
    title { "MyString" }
    genre { "MyString" }
    year { "MyString" }
    country { "MyString" }
    published_at { "2023-04-06" }
    description { "MyText" }
  end
end
