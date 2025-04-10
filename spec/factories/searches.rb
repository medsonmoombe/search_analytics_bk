FactoryBot.define do
    factory :search do
      query { Faker::ProgrammingLanguage.name }
      ip_address { Faker::Internet.ip_v4_address }
    end
  end