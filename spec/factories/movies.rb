FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.word }
    gender { "MyString" }
    release_year { "MyString" }
    country { "MyString" }
    date_added { "2023-04-06" }
    description { "MyText" }
  end
end
