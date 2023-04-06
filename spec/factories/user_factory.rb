# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # name { Faker::TvShows::TheOffice.character }
    password { '123456789' }
    email { Faker::Internet.unique.email }
  end
end
